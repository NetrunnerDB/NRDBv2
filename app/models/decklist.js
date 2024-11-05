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
    return this.store.findRecord('card', this.identityCardId, {
      include: 'printings',
    });
  }

  @hasMany('card', { async: true, inverse: null }) cards;
}
