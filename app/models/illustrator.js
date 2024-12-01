import Model, { attr, hasMany } from '@ember-data/model';

export default class IllustratorModel extends Model {
  @attr name;
  @attr numPrintings;
  @attr updatedAt;

  // The illustrator page accordion panels don't work if async is set to false.
  @hasMany('printing', { async: true, inverse: 'illustrators' }) printings;
}
