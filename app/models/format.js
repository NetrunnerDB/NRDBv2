import Model, { attr, hasMany } from '@ember-data/model';

export default class FormatModel extends Model {
  @attr name;
  @attr activeSnapshotId;
  @attr activeCardPoolId;
  @attr activeRestrictionId;
  @attr snapshotIds;
  @attr restrictionIds;
  @attr updatedAt;

  @hasMany('card-pool', { async: true, inverse: 'format' }) cardPools;
  @hasMany('restriction', { async: true, inverse: null }) restrictions;
  @hasMany('snapshot', { async: true, inverse: 'format' }) snapshots;
}
