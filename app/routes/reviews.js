import Route from '@ember/routing/route';
import { service } from '@ember/service';
export default class ReviewsRoute extends Route {
  @service store;

  async model() {
    let reviews = await this.store.query('review', {
      // sort: '-createdAt',
      includes: ['card'],
      page: { size: 10 },
    });

    // Return the reviews as the model for this route
    return {
      reviews,
    };
  }
}
