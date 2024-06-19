import Model, { attr, belongsTo, hasMany } from '@ember-data/model';

export default class CardSetModel extends Model {
  @attr name;
  @attr('date') dateRelease;
  @attr size;
  @attr cardCycleId;
  @attr cardSetTypeId;
  @attr legacyCode;
  @attr firstPrintingId;
  @attr releasedBy;
  @attr firstPrintingId;
  @attr('date') updatedAt;

  @belongsTo('card-cycle', { async: true, inverse: 'cardSets' }) cardCycle;
  @belongsTo('card-set-type', { async: true, inverse: 'cardSets' }) cardSetType;
  @hasMany('card', { async: true, inverse: null }) cards;
  @hasMany('printing', { async: true, inverse: 'cardSet' }) printings;

  get isBooster() {
    return this.cardSetTypeId === 'booster_pack';
  }
}
