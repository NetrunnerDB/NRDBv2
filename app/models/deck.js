import Model, { attr } from '@ember-data/model';

export default class DeckModel extends Model {
  @attr name;
  @attr description;
  @attr isMini;
  @attr sideId;
  @attr followsBasicDeckbuildingRules;
  @attr identityCardId;
  @attr influenceSpent;
  @attr notes;
  @attr numCards;
  @attr createdAt;
  @attr updatedAt;
  @attr tags;
  @attr userId;

  // There are no relationships defined yet because of limitations on the API server at the moment.
}
