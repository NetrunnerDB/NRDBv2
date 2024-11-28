import Model, { attr, hasMany } from '@ember-data/model';

export default class CardCycleModel extends Model {
  @attr name;
  @attr('date') dateRelease;
  @attr legacyCode;
  @attr cardSetIds;
  @attr firstPrintingId;
  @attr position;
  @attr releasedBy;
  @attr('date') updatedAt;

  @hasMany('card-set', { async: true, inverse: 'cardCycle' }) cardSets;
  @hasMany('card', { async: true, inverse: null }) cards;
  @hasMany('printing', { async: true, inverse: 'cardCycle' }) printings;

  get cardCount() {
    return (async () => {
      let cs = await this.cardSets;
      return cs
        .filter((set) => !set.isBooster)
        .reduce((sum, set) => sum + set.size, 0);
    })();
  }
}
