import Route from '@ember/routing/route';
import { service } from '@ember/service';
import { hash } from 'rsvp';

export default class AdvancedSearchRoute extends Route {
  @service store;

  async model() {
    let cardTypes = this.store.findAll('card-type');
    let cardSubtypes = this.store.findAll('card-sub-type');
    let cardSets = this.store.findAll('card-set');
    let factions = this.store.findAll('faction');

    return hash({ cardTypes, cardSubtypes, cardSets, factions });
  }
}
