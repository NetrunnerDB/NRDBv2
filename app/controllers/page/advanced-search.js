import Controller from '@ember/controller';
import { tracked } from '@glimmer/tracking';

export default class AdvancedSearchController extends Controller {
  queryParams = ['display'];

  @tracked display = 'checklist';
}
