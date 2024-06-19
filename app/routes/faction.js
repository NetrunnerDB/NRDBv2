import Route from '@ember/routing/route';
import { service } from '@ember/service';
import { hash } from 'rsvp';
import { Hyphenate } from 'netrunnerdb/helpers/hyphenate';

export default class FactionRoute extends Route {
  @service store;

  async model(params) {
    // Get the faction object
    let faction = await this.store.findRecord('faction', params.id);

    // Add a hyphenated ID attribute because the hyphenate helper doesn't work because ???
    faction.idHyphenated = Hyphenate(faction.id);

    // Get all ids for the faction
    // TODO: sort ids by legality then alphabetically
    // TODO: add a way to the API to determine a card's legality in a format without pulling that format
    let ids = this.store
      .query('card', {
        filter: { search: `t:identity f:${params.id}` },
        include: 'printings',
      })
      .then((ids) => {
        ids.forEach((id) => {
          id.latestPrinting = id.printings.find(
            (p) => p.id == id.latestPrintingId,
          );
          id.decklists = this.store.query('decklist', {
            filter: { identity_card_id: id.id },
            sort: '-created_at',
            page: { limit: 3 },
          });
        });
        return ids;
      });

    return hash({ faction, ids });
  }

  decklistCount(id) {
    if ('decklist' in id) {
      return id.decklist.length;
    }
    return -1;
  }
}
