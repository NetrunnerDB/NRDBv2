import Route from '@ember/routing/route';
import { service } from '@ember/service';
import { hash } from 'rsvp';

export default class DecklistRoute extends Route {
  @service store;

  async model({ id }) {
    let cardTypes = this.store.findAll('card-type');
    let decklist = this.store.findRecord('decklist', id, {
      include: 'cards,cards.printings',
    });

    return hash({ cardTypes, decklist });
  }
}
