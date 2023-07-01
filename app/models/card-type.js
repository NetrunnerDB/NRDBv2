import Model, { attr, belongsTo, hasMany } from '@ember-data/model';

export default class CardTypeModel extends Model {
  @attr name;
  @attr sideId;
  @attr updatedAt;

  @belongsTo('side', { async: true, inverse: 'cardTypes' }) side;
  @hasMany('card', { async: true, inverse: 'cardType' }) cards;
}
