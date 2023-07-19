import Controller from '@ember/controller';
import { tracked } from '@glimmer/tracking';

export default class PageSearchController extends Controller {
  @tracked sortingField;
  @tracked sortDescending = false;

  get results() {
    let res = [];
    let sorted = res.sortBy(this.sortingField);

    return this.sortDescending ? sorted.reverse() : sorted;
  }
}
