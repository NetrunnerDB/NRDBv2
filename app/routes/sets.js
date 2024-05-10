import Route from '@ember/routing/route';
import { get } from '@ember/helper';
import { service } from '@ember/service';
import { formatDate } from '../helpers/format-date';
import { Hyphenate } from '../helpers/hyphenate';

export default class SetsRoute extends Route {
  @service store;

  async model(params) {
    return this.store.query('cardCycle', {
      include: ['card_sets'],
      sort: '-position',
    });
  }
}
