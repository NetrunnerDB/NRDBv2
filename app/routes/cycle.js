import Route from '@ember/routing/route';
import { service } from '@ember/service';
import { hash } from 'rsvp';

export default class CyclesRoute extends Route {
  @service store;

  async model(params) {
    let cardCycle = this.store.findRecord('cardCycle', params.id, {
      include: ['printings', 'printings.card_type'],
    });

    let allCycles = await this.store.query('cardCycle', {
      sort: 'date_release',
    });

    let cycleIndex = allCycles.findIndex((cycle) => cycle.id == params.id);
    let nextCycle =
      cycleIndex < allCycles.length - 1 ? allCycles[cycleIndex + 1] : null;
    let prevCycle = cycleIndex > 0 ? allCycles[cycleIndex - 1] : null;

    return hash({ cardCycle, nextCycle, prevCycle });
  }
}
