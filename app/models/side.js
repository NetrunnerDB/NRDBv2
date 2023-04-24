import Model, { attr, hasMany } from '@ember-data/model';

export default class SideModel extends Model {
  @attr name;
  @attr updatedAt;

  @hasMany('faction', { async: true, inverse: 'side' }) factions;
  @hasMany('card_types', { async: true, inverse: null }) cards; // TODO: this breaks if you connect it to card_types
  @hasMany('card', { async: true, inverse: 'side' }) cards;
  @hasMany('printing', { async: true, inverse: 'side' }) printings;
}
