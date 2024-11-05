import Route from '@ember/routing/route';
import { service } from '@ember/service';
import { all, hash } from 'rsvp';

export default class DecklistRoute extends Route {
  @service store;

  async model(params) {
    let cardTypes = await this.store.findAll('cardType');

    let decklist = await this.store.findRecord('decklist', params.id, {
      include: 'cards,cards.printings',
    });

    let cards = decklist.cards.map((card) => {
      card.printing = this.store.findRecord('printing', card.latestPrintingId);
      return card;
    });

    let cardsByType = {};
    cardTypes.forEach((type) => {
      cardsByType[type.id] = [];
    });
    cards.forEach((card) => {
      cardsByType[card.cardTypeId].push(card);
    });

    let countsByType = {};
    cardTypes.forEach((type) => {
      countsByType[type.id] = 0;
    });
    cards.forEach((card) => {
      countsByType[card.cardTypeId] += decklist.cardSlots[card.id];
    });

    // Update the value of each printing's quantity to trick the CardList component into displaying the number of each card in the deck insteaad of its set
    let printings = all(
      cards.map((card) =>
        card.printing.then((printing) => {
          printing.quantity = decklist.cardSlots[card.id];
          return printing;
        }),
      ),
    );

    return hash({ decklist, cardTypes, cardsByType, countsByType, printings });
  }
}
