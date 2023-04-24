import Model, { attr, hasMany } from '@ember-data/model';

export default class IllustratorModel extends Model {
  @attr name;
  @attr numPrintings;
  @attr updatedAt;

  @hasMany('printing', { async: true, inverse: 'illustrators' }) printings;
}
