import Controller from '@ember/controller';
import { tracked } from '@glimmer/tracking';

export default class AdvancedSearchController extends Controller {
  queryParams = ['display', 'query'];

  @tracked display = 'checklist';
  @tracked query = '';
}
