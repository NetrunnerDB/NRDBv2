import Route from '@ember/routing/route';
import { service } from '@ember/service';
import { hash } from 'rsvp';

export default class IllustratorsRoute extends Route {
  @service store;

  async model() {
    let illustrators = this.store.query('illustrator', {
      include: ['printings'],
      page: { size: 1000 },
    });

    return hash({ illustrators });
  }
}
