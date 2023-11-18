import Controller from '@ember/controller';
import { tracked } from '@glimmer/tracking';

export default class BasicSearchController extends Controller {
  queryParams = ['display', 'max_records', 'query'];

  @tracked display = 'checklist';
  @tracked query = '';
  @tracked max_records = 100;
}
