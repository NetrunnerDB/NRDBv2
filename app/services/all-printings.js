import Service from '@ember/service';
import { service } from '@ember/service';
import { tracked } from '@glimmer/tracking';
import { storageFor } from 'ember-local-storage';

export default class AllPrintingsService extends Service {
  @service store;

  @tracked allPrintings = [];
  #loadPromise = null;
  @storageFor('all-printings') allPrintingsCache;

  async needsRefresh() {
    try {
      let resp = await fetch('https://api.netrunnerdb.com/api/v3/public/cards?sort=-updated_at&page[size]=1');
      if (!resp.ok) return true;
      let data = await resp.json();
      let updated = data?.data?.[0]?.attributes?.updated_at;
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

        // 1) Load cached compact index if available and not stale
        let cached = this.allPrintingsCache?.get?.('items') || [];
        let stale = await this.needsRefresh();
        if (!stale && cached.length > 0) {
          this.allPrintings = cached;
          return;
        }

        // 2) Fetch and persist compact index
        let printings = await this.store.query('printing', { page: { size: 5000 } });
        let compact = [];
        if (printings && typeof printings.forEach === 'function') {
          printings.forEach((p) => {
            compact.push({
              id: p.id,
              title: p.title,
              displaySubtypes: p.displaySubtypes,
              factionId: p.factionId,
              cardTypeId: p.cardTypeId,
            });
          });
        }
        this.allPrintings = compact;
        this.allPrintingsCache?.set?.('items', compact);
        this.allPrintingsCache?.set?.('updatedAt', new Date().toISOString());

        try {
          let resp = await fetch('https://api.netrunnerdb.com/api/v3/public/cards?sort=-updated_at&page[size]=1');
          if (resp.ok) {
            let data = await resp.json();
            let updated = data?.data?.[0]?.attributes?.updated_at;
            if (updated) this.allPrintingsCache?.set?.('remoteUpdatedAt', updated);
          }
        } catch (e) {
          console.error("error fetching remote updated at", e);
        }
      } catch (e) {
        console.error("error loading printings", e);
        this.allPrintings = [];
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


