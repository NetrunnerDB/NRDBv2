import Model, { attr, belongsTo } from '@ember-data/model';

export default class RulingModel extends Model {
  @attr cardId;
  @attr nsgRulesTeamVerified;
  @attr textRuling;
  @attr question;
  @attr answer;
  @attr updatedAt;

  @belongsTo('card', { async: false, inverse: 'rulings' }) card;
}
