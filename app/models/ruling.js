import Model, { attr, belongsTo } from '@ember-data/model';

export default class RulingModel extends Model {
  @attr cardId;
  @attr nsgRulesTeamVerified;
  @attr textRuling;
  @attr question;
  @attr answer;
  @attr updatedAt;

  @belongsTo('card', { async: true, inverse: 'rulings' }) card;
}
