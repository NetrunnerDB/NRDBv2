import Route from '@ember/routing/route';
import { service } from '@ember/service';
// import RSVP from 'rsvp';

export default class PageCardRoute extends Route {
  @service store;

  async model(params) {
    let id = params.id;

    // Card pages display a printing, not an abstract card
    // If the given ID is not a printing ID, treat it as a card ID and find its latest printing
    if (isNaN(parseInt(id))) {
      let parsed = await this.store.findRecord('card', id);
      id = parsed.get('latestPrintingId');
    }

    // Get the printing
    let printing = await this.store.findRecord('printing', id);

    return printing;
  }
}
