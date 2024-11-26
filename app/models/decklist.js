import Model, { attr, hasMany } from '@ember-data/model';

export default class CardCycleModel extends Model {
  @attr userId;
  @attr followsBasicDeckbuildingRules;
  @attr identityCardId;
  @attr name;
  @attr notes;
  @attr tags;
  @attr sideId;
  @attr('date') createdAt;
  @attr('date') updatedAt;
  @attr factionId;
  @attr cardSlots;
  @attr numCards;
  @attr influenceSpent;

  get identityCard() {
    return this.cards.find((card) => card.id === this.identityCardId);
  }

  @hasMany('card', { inverse: null }) cards;
}
