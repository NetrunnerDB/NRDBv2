import Route from '@ember/routing/route';
import { service } from '@ember/service';
import { htmlSafe } from '@ember/template';
import { hash } from 'rsvp';

export default class HomeRoute extends Route {
  @service store;

  async model() {
    let decklists = await this.store.query('decklist', {
      sort: '-created_at',
      page: { size: 10 },
    });

    // Set the latest decklist in the API as the dotw (temporary selection process)
    let dotw, dotwDesc, latestDecklists;
    if (decklists.length > 0) {
      dotw = decklists[0];
      dotwDesc = htmlSafe(dotw.notes);

      latestDecklists = decklists.slice(0, 10);
    }

    return hash({
      dotw,
      dotwDesc,
      latestDecklists,
    });
  }
}
