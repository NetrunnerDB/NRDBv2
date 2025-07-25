import Route from '@ember/routing/route';
import { service } from '@ember/service';
import { hash } from 'rsvp';

export default class SetsRoute extends Route {
  @service store;

  async model(params) {
    let cardSet = this.store.findRecord('card-set', params.id, {
      include: ['printings', 'printings.card_type'],
    });

    let allSets = await this.store.query('card-set', {
      sort: 'date_release',
    });
    let setIndex = allSets.findIndex((set) => set.id == params.id);
    let nextSet = setIndex < allSets.length - 1 ? allSets[setIndex + 1] : null;
    let prevSet = setIndex > 0 ? allSets[setIndex - 1] : null;

    return hash({ cardSet, nextSet, prevSet });
  }
}
