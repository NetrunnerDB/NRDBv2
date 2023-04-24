import Model, { attr } from '@ember-data/model';

export default class RestrictionModel extends Model {
  @attr name;
  @attr dateStart;
  @attr pointLimit;
  @attr verdicts;
  @attr bannedSubtypes;
  @attr size;
  @attr updatedAt;
}
