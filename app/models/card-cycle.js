import Model, { attr, hasMany } from '@ember-data/model';

export default class CardCycleModel extends Model {
  @attr name;
  @attr('date') dateRelease;
  @attr legacyCode;
  @attr cardSetIds;
  @attr firstPrintingId;
  @attr('date') updatedAt;

  @hasMany('card-set', { async: true, inverse: 'cardCycle' }) cardSets;
  @hasMany('card', { async: true, inverse: null }) cards;
  @hasMany('printing', { async: true, inverse: 'cardCycle' }) printings;

  get cardCount() {
    return this.cardSets
      .filter((set) => !set.isBooster)
      .reduce((sum, set) => sum + set.size, 0);
  }
}
