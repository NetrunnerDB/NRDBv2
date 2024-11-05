import Route from '@ember/routing/route';
import { service } from '@ember/service';
import { all, hash } from 'rsvp';

export default class DecklistRoute extends Route {
  @service store;

  async model(params) {
    let cardTypes = await this.store.findAll('cardType');

    let decklist = await this.store.findRecord('decklist', params.id, {
      include: 'cards',
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

    return hash({
      decklist: decklist,
      cardTypes: cardTypes,
      cardsByCategory: this.formatCards(cards, cardTypes, decklist),
      cardsByType: cardsByType,
      countsByType: countsByType,
      printings: printings,
    });
  }

  // Counts the number of individual cards in a decklist are from a list of distinct cards
  countCards(cards, decklist) {
    let count = 0;
    cards.forEach((card) => {
      count += decklist.cardSlots[card.id];
    });
    return count;
  }

  // Sorts a decklist's cards into an array of arrays of objects:
  // [[{
  //   name
  //   cardTypeId
  //   cards
  //   count
  // }]]
  // Each top level array represents a column on the decklist view
  // Each nested array represents the types (or subtypes) of cards within each subtype
  formatCards(cards, cardTypes, decklist) {
    let row1CardTypes = cardTypes.filter((type) =>
      [
        'agenda',
        'asset',
        'operation',
        'upgrade',
        'event',
        'hardware',
        'resource',
      ].includes(type.id),
    );
    let row2CardTypes = cardTypes.filter((type) =>
      ['ice', 'program'].includes(type.id),
    );

    let row1Cards = row1CardTypes.map((type) => {
      let cs = cards.filter((card) => card.cardTypeId == type.id);
      return {
        name: type.name,
        cardTypeId: type.id,
        cards: cs,
        count: this.countCards(cs, decklist),
      };
    });

    let row2Cards = [];
    row2CardTypes.forEach((type) => {
      if (type.id == 'ice') {
        let data = this.formatIce(cards);
        row2Cards.push({
          name: 'Barrier',
          cardTypeId: 'ice',
          cards: data.barriers,
          count: this.countCards(data.barriers, decklist),
        });
        row2Cards.push({
          name: 'Code Gate',
          cardTypeId: 'ice',
          cards: data.codeGates,
          count: this.countCards(data.codeGates, decklist),
        });
        row2Cards.push({
          name: 'Sentry',
          cardTypeId: 'ice',
          cards: data.sentries,
          count: this.countCards(data.sentries, decklist),
        });
        row2Cards.push({
          name: 'Multi',
          cardTypeId: 'ice',
          cards: data.multis,
          count: this.countCards(data.multis, decklist),
        });
        row2Cards.push({
          name: 'Other',
          cardTypeId: 'ice',
          cards: data.misc,
          count: this.countCards(data.misc, decklist),
        });
      } else {
        let data = this.formatPrograms(cards);
        row2Cards.push({
          name: 'Icebreaker',
          cardTypeId: 'program',
          cards: data.icebreakers,
          count: this.countCards(data.icebreakers, decklist),
        });
        row2Cards.push({
          name: 'Program',
          cardTypeId: 'program',
          cards: data.misc,
          count: this.countCards(data.misc, decklist),
        });
      }
    });

    return [row1Cards, row2Cards];
  }

  // Collect the ice from a list of cards and separate them by subtype
  formatIce(cards) {
    cards = cards.filter((card) => card.cardTypeId == 'ice');

    let barriers = [];
    let codeGates = [];
    let sentries = [];
    let multis = [];
    let misc = [];

    cards.forEach((card) => {
      let isBarrier = card.cardSubtypeIds.includes('barrier');
      let isCodeGate = card.cardSubtypeIds.includes('code_gate');
      let isSentry = card.cardSubtypeIds.includes('sentry');

      if (
        (isBarrier && isCodeGate) ||
        (isBarrier && isSentry) ||
        (isCodeGate && isSentry)
      ) {
        multis.push(card);
      } else if (isBarrier) {
        barriers.push(card);
      } else if (isCodeGate) {
        codeGates.push(card);
      } else if (isSentry) {
        sentries.push(card);
      } else {
        misc.push(card);
      }
    });

    return {
      barriers: barriers,
      codeGates: codeGates,
      sentries: sentries,
      multis: multis,
      misc: misc,
    };
  }

  // Collect the programs from a list of cards and separate them by icebreaker vs non-icebreaker
  formatPrograms(cards) {
    cards = cards.filter((card) => card.cardTypeId == 'program');

    let icebreakers = cards.filter((card) =>
      card.cardSubtypeIds.includes('icebreaker'),
    );
    let misc = cards.filter(
      (card) => !card.cardSubtypeIds.includes('icebreaker'),
    );

    return {
      icebreakers: icebreakers,
      misc: misc,
    };
  }
}
