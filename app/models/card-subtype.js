import Model, { attr, hasMany } from '@ember-data/model';

export default class CardSubtypeModel extends Model {
  @attr name;
  @attr updatedAt;

  @hasMany('card', { async: true, inverse: 'cardSubtypes' }) cards;
  @hasMany('printing', { async: true, inverse: null }) printings;
}
