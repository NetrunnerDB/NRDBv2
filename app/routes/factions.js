import Route from '@ember/routing/route';
import { service } from '@ember/service';
import { hash } from 'rsvp';

export default class FactionRoute extends Route {
  @service store;

  async model(params) {
    let factions = this.store.findAll('faction').then(function (factions) {
      return factions.reduce(function (obj, faction) {
        obj[faction.get('id')] = faction.get('description');
        return obj;
      });
    });
    return factions;
  }
}
