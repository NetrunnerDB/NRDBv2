import Service from '@ember/service';
import { service } from '@ember/service';
import { tracked } from '@glimmer/tracking';
import { storageFor } from 'ember-local-storage';

export default class AllPrintingsService extends Service {
  @service store;

  @tracked allPrintings = [];
  #loadPromise = null;
  @storageFor('all-printings') allPrintingsCache;

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

  async loadPrintings() {
    if (this.#loadPromise) return this.#loadPromise;

    this.#loadPromise = (async () => {
      try {
        // 1) Load from cache first if available
        let cached = this.allPrintingsCache?.get?.('items') || [];
        if (cached.length > 0) {
          this.allPrintings = cached;
        }

        // 2) Check freshness in background
        let remoteUpdatedAt = await this.getRemoteUpdatedAt();
        let cachedRemote = this.allPrintingsCache?.get?.('remoteUpdatedAt');
        let stale = !remoteUpdatedAt || !cachedRemote || new Date(remoteUpdatedAt) > new Date(cachedRemote);
        
        // 3) If data is fresh or we have no cached data, return early
        if (!stale && cached.length > 0) {
          return;
        }

        // 4) Fetch and persist fresh data if stale or no cache
        let printings = await this.store.query('printing', { page: { size: 5000 } });
        let compact = printings.map((p) => {
          return {
              id: p.id,
              title: p.title,
          };
        });

        this.allPrintings = compact;
        this.allPrintingsCache?.set?.('items', compact);
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


