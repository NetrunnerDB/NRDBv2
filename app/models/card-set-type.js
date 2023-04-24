import Model, { attr, hasMany } from '@ember-data/model';

export default class CardSetTypeModel extends Model {
  @attr name;
  @attr description;
  @attr updatedAt;

  @hasMany('card-set', { async: true, inverse: 'cardSetType' }) cardSets;
}
