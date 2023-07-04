import Model, { attr, belongsTo, hasMany } from '@ember-data/model';

export default class CardPoolModel extends Model {
  @attr name;
  @attr cardCycleIds;
  @attr cardSetIds;
  @attr cardIds;
  @attr numCards;
  @attr updatedAt;

  @belongsTo('format', { async: true, inverse: 'cardPools' }) format;
  @hasMany('card-cycle', { async: true, inverse: null }) cardCycles;
  @hasMany('card-set', { async: true, inverse: null }) cardSets;
  @hasMany('card', { async: true, inverse: null }) cards;
  @hasMany('snapshot', { async: true, inverse: 'cardPool' }) snapshots;
}
