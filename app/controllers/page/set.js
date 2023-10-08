import Controller from '@ember/controller';
import { tracked } from '@glimmer/tracking';

export default class SetController extends Controller {
  queryParams = ['display'];

  @tracked display = 'checklist';
}
