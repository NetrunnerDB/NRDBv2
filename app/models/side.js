import Model, { attr, hasMany } from '@ember-data/model';

export default class SideModel extends Model {
  @attr name;
  @attr updatedAt;

  @hasMany('faction', { async: true, inverse: 'side' }) factions;
  @hasMany('card-type', { async: true, inverse: 'side' }) cardTypes;
  @hasMany('card', { async: true, inverse: 'side' }) cards;
  @hasMany('printing', { async: true, inverse: 'side' }) printings;
}
