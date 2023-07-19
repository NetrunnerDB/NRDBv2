import Model, { attr } from '@ember-data/model';

export default class RestrictionModel extends Model {
  @attr name;
  @attr('date') dateStart;
  @attr pointLimit;
  @attr verdicts;
  @attr bannedSubtypes;
  @attr size;
  @attr('date') updatedAt;
}
