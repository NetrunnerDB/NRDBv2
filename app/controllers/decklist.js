import Controller from '@ember/controller';
import { tracked } from '@glimmer/tracking';
import { htmlSafe } from '@ember/template';
// import InfluencePips from 'netrunnerdb/components/card/influence-pips';

export default class DecklistController extends Controller {
  // ENUM: writeup, list, images
  @tracked displayType = 'writeup';

  displayWriteUp = () => {
    this.displayType = 'writeup';
  };
  displayList = () => {
    this.displayType = 'list';
  };
  displayImages = () => {
    this.displayType = 'images';
  };

  displayHtml(source) {
    return htmlSafe(source);
  }

  get cardsByType() {
    let cards = this.model.decklist.cards;
    let cardTypes = this.model.cardTypes.toArray();

    let cardsByType = {};
    cardTypes.forEach((type) => {
      cardsByType[type.id] = [];
    });
    cards.forEach((card) => {
      cardsByType[card.cardTypeId].push(card);
    });

    return cardsByType;
  }

  get countsByType() {
    let decklist = this.model.decklist;
    let cards = this.model.decklist.cards;
    let cardTypes = this.model.cardTypes.toArray();

    let countsByType = {};
    cardTypes.forEach((type) => {
      countsByType[type.id] = 0;
    });
    cards.forEach((card) => {
      countsByType[card.cardTypeId] += decklist.cardSlots[card.id];
    });

    return countsByType;
  }

  constructor(...args) {
    super(...args);

    // TODO: set initial value of displayType to the current user's default preference
  }
}
