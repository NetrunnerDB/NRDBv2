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

  constructor(...args) {
    super(...args);

    // TODO: set initial value of displayType to the current user's default preference
  }
}
