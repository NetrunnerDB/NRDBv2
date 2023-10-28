import Controller from '@ember/controller';
import { tracked } from '@glimmer/tracking';

export default class AdvancedSearchController extends Controller {
  queryParams = [
    'display',
    'query',
    'max_records',
    'latest_printing_only',
    'title',
    'flavor',
  ];

  @tracked display = 'checklist';
  @tracked query = '';
  @tracked max_records = '25';
  @tracked latest_printing_only = false;
  @tracked title = '';
  @tracked text = '';
  @tracked flavor = '';
}
