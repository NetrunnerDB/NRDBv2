import Model, { attr, belongsTo, hasMany } from '@ember-data/model';

export default class FactionModel extends Model {
  @attr name;
  @attr description;
  @attr isMini;
  @attr sideId;
  @attr updatedAt;

  @belongsTo('side', { async: true, inverse: 'factions' }) side;
  @hasMany('card', { async: true, inverse: 'faction' }) cards;
  @hasMany('printing', { async: true, inverse: 'faction' }) printings;
}
