import Route from '@ember/routing/route';
import { service } from '@ember/service';
import { htmlSafe } from '@ember/template';
import { hash } from 'rsvp';
import { range } from '../helpers/range';

export default class HomeRoute extends Route {
  @service store;

  async model(params) {
    let decklists = await this.store.findAll('decklist', {
      filter: { sort: '-created_at' },
      page: { limit: 10 },
    });

    // Set the latest decklist in the API as the dotw (temporary selection process)
    let dotw = decklists[0];
    let dotwDesc = htmlSafe(dotw.notes);

    let latestDecklists = decklists.slice(0, 10);

    return hash({
      dotw: dotw,
      dotwDesc: dotwDesc,
      latestDecklists: latestDecklists,
    });
  }
}
