import Service from '@ember/service';
import { service } from '@ember/service';
import { tracked } from '@glimmer/tracking';
import { storageFor } from 'ember-local-storage';
import LZString from 'lz-string';

export default class AllPrintingsService extends Service {
  @service store;

  @tracked allPrintings = [];
  #loadPromise = null;
  @storageFor('all-printings') allPrintingsCache;

  // Compression helpers
  compressData(data) {
    try {
      const jsonString = JSON.stringify(data);
      return LZString.compress(jsonString);
    } catch (e) {
      console.error('Error compressing data:', e);
      return null;
    }
  }

  decompressData(compressedData) {
    try {
      if (!compressedData) return null;
      const decompressed = LZString.decompress(compressedData);
      return decompressed ? JSON.parse(decompressed) : null;
    } catch (e) {
      console.error('Error decompressing data:', e);
      return null;
    }
  }

  // Enhanced cache methods with compression
  getCachedItems() {
    const compressed = this.allPrintingsCache?.get?.('items');
    return this.decompressData(compressed) || [];
  }

  setCachedItems(items) {
    const compressed = this.compressData(items);
    if (compressed) {
      this.allPrintingsCache?.set?.('items', compressed);
    }
  }

  async getRemoteUpdatedAt() {
    try {
      let cards = await this.store.query('card', {
        sort: '-updated_at',
        page: { size: 1 },
        fields: { cards: 'updated_at' },
      });
      let first = cards?.[0];
      return first?.updatedAt ?? null;
    } catch (_e) {
      return null;
    }
  }

  async needsRefresh() {
    try {
      let updated = await this.getRemoteUpdatedAt();
      if (!updated) return true;
      let cachedRemote = this.allPrintingsCache?.get?.('remoteUpdatedAt');
      return !cachedRemote || new Date(updated) > new Date(cachedRemote);
    } catch (e) {
      console.error("error checking if needs refresh", e);
      return true;
    }
  }

  async loadPrintings(forceRefresh = false) {
    // Reset load promise if forcing refresh
    if (forceRefresh) {
      this.#loadPromise = null;
    }
    
    if (this.#loadPromise) return this.#loadPromise;

    this.#loadPromise = (async () => {
      try {
        // 1) Load from cache first if available (unless forcing refresh)
        let cached = this.getCachedItems();
        if (cached.length > 0 && !forceRefresh) {
          this.allPrintings = cached;
        }

        // 2) Check freshness in background
        let remoteUpdatedAt = await this.getRemoteUpdatedAt();
        let cachedRemote = this.allPrintingsCache?.get?.('remoteUpdatedAt');
        let stale = forceRefresh || !remoteUpdatedAt || !cachedRemote || new Date(remoteUpdatedAt) > new Date(cachedRemote);
        
        // 3) If data is fresh and not forcing refresh, return early
        if (!stale && cached.length > 0) {
          return;
        }

        // 4) Fetch and persist fresh data if stale or no cache
        let printings = await this.store.query('printing', { page: { size: 5000 } });
        let compact = printings.map((p) => {
          // Serialize all attributes and properties from the printing object
          let serialized = p.serialize();
          return {
            id: p.id,
            ...serialized.data.attributes
          };
        });

        this.allPrintings = compact;
        this.setCachedItems(compact);
        this.allPrintingsCache?.set?.('updatedAt', new Date().toISOString());

        if (remoteUpdatedAt) {
          this.allPrintingsCache?.set?.('remoteUpdatedAt', remoteUpdatedAt);
        }
      } catch (e) {
        console.error("error loading printings", e);
      } finally {
      }
    })();

    return this.#loadPromise;
  }

  normalize(str) {
    return str.toLowerCase().normalize('NFD').replace(/\p{Diacritic}/gu, '');
  }

  filterLocal(query) {
    let q = this.normalize(query || '');
    if (!q) return [];

    const matches = this.allPrintings.filter((p) => {
      let title = this.normalize(p.title);
      return title.includes(q);
    });

    // matches that start with the query are prioritized
    return matches.sort((a, b) => {
      let aStartsWith = this.normalize(a.title).startsWith(q);
      let bStartsWith = this.normalize(b.title).startsWith(q);
      if (aStartsWith && !bStartsWith) return -1;
      if (!aStartsWith && bStartsWith) return 1;
      return 0;
    });
  }

  search(query, limit) {
    return this.filterLocal(query).slice(0, limit);
  }
}


