import Model, { attr, hasMany } from '@ember-data/model';

export default class CardCycleModel extends Model {
  @attr name;
  @attr dateRelease;
  @attr legacyCode;
  @attr cardSetIds;
  @attr updatedAt;

  @hasMany('card-set', { async: true, inverse: 'cardCycle' }) cardSets;
  @hasMany('card', { async: true, inverse: null }) cards;
  @hasMany('printing', { async: true, inverse: 'cardCycle' }) printings;
}
