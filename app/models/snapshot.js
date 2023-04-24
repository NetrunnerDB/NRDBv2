import Model, { attr, belongsTo, hasMany } from '@ember-data/model';

export default class SnapshotModel extends Model {
  @attr formatId;
  @attr active;
  @attr cardCycleIds;
  @attr cardSetIds;
  @attr cardPoolId;
  @attr restrictionId;
  @attr dateStart;
  @attr numCards;
  @attr updatedAt;

  @belongsTo('format', { async: true, inverse: 'snapshots' }) format;
  @belongsTo('card-pool', { async: true, inverse: 'snapshots' }) cardPool;
  @belongsTo('restriction', { async: true, inverse: null }) restriction;
  @hasMany('cards', { async: true, inverse: null }) restriction;
}
