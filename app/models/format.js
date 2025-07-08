import Model, { attr, hasMany } from '@ember-data/model';

export default class FormatModel extends Model {
  @attr name;
  @attr activeSnapshotId;
  @attr activeCardPoolId;
  @attr activeRestrictionId;
  @attr snapshotIds;
  @attr restrictionIds;
  @attr updatedAt;

  get activeSnapshot() {
    return this.hasMany('snapshot')
      .value()
      ?.find((snapshot) => snapshot.id === this.activeSnapshotId);
  }

  get currentRestriction() {
    return this.hasMany('restrictions')
      .value()
      ?.find((restriction) => restriction.id === this.activeRestrictionId);
  }

  @hasMany('card-pool', { async: true, inverse: 'format' }) cardPools;
  @hasMany('restriction', { async: true, inverse: null }) restrictions;
  @hasMany('snapshot', { async: true, inverse: 'format' }) snapshots;
}
