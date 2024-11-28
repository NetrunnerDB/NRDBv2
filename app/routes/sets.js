import Route from '@ember/routing/route';
import { service } from '@ember/service';
import { hash } from 'rsvp';

export default class SetsRoute extends Route {
  @service store;

  async model() {
    let cycles = this.store.query('cardCycle', {
      include: ['card_sets'],
      sort: '-date_release',
    });

    // Fetch active snapshots for the 3 main formats.
    let formats = await this.store.query('snapshot', {
      filter: { active: true, format_id: ['eternal', 'standard', 'startup'] },
    });
    let standard =
      formats[formats.findIndex(({ formatId }) => formatId == 'standard')];
    let startup =
      formats[formats.findIndex(({ formatId }) => formatId == 'startup')];
    let eternal =
      formats[formats.findIndex(({ formatId }) => formatId == 'eternal')];

    return hash({ cycles, standard, startup, eternal });
  }
}
