import Controller from '@ember/controller';
import { tracked } from '@glimmer/tracking';

export default class CycleController extends Controller {
  queryParams = ['display'];

  @tracked display = 'checklist';
}
