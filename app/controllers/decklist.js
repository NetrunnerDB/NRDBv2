import Controller from '@ember/controller';
import { tracked } from '@glimmer/tracking';

export default class DecklistController extends Controller {
  // ENUM: writeup, list, images
  queryParams = ['display'];

  @tracked display = 'writeup';
}
