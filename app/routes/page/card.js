import Route from '@ember/routing/route';
import { service } from '@ember/service';
import { hash } from 'rsvp';

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

    // Fetch active snapshots for the 3 main formats.
    let formats = await this.store.query('snapshot', {
      filter: { active: true, format_id: ['eternal', 'standard', 'startup'] },
    });
    let eternalSnapshot = undefined;
    let standardSnapshot = undefined;
    let startupSnapshot = undefined;
    formats.forEach((f) => {
      if (f.formatId == 'eternal') {
        eternalSnapshot = f;
      } else if (f.formatId == 'standard') {
        standardSnapshot = f;
      } else if (f.formatId == 'startup') {
        startupSnapshot = f;
      }
    });

    return hash({
      printing,
      eternalSnapshot,
      standardSnapshot,
      startupSnapshot,
    });
  }
}
