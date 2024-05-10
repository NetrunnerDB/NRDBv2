import Route from '@ember/routing/route';
import { service } from '@ember/service';
import { hash } from 'rsvp';

export default class FactionRoute extends Route {
  @service store;

  async model(params) {
    // Get the faction object
    let faction = this.store.findRecord('faction', params.id);

    // Get all ids for the faction
    // TODO: sort ids by legality then alphabetically
    // TODO: add a way to the API to determine a card's legality in a format without pulling that format
    let ids = this.store
      .query('card', {
        filter: { search: `t:identity f:${params.id}` },
        include: 'printings',
      })
      .then(function (ids) {
        ids.forEach(function (id) {
          id.latestPrinting = id.printings.find(
            (p) => p.id == id.latestPrintingId,
          );
        });
        return ids;
      });

    // TEMP
    let decklists = this.store.query('decklist', {
      sort: '-created_at',
      page: { limit: 3 },
    });

    return hash({ faction, ids, decklists });
  }
}
