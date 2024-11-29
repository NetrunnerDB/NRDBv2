import Model, { attr, belongsTo } from '@ember-data/model';

export default class ReviewModel extends Model {
  @attr cardId;
  @attr username;
  @attr body;
  @attr votes;
  @attr createdAt;
  @attr comments;

  @belongsTo('card', { async: false, inverse: 'reviews' }) card;
}
