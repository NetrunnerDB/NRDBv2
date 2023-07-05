import Controller from '@ember/controller';
import { tracked } from '@glimmer/tracking';

export default class BanlistsController extends Controller {
  queryParams = ['format'];

  @tracked format = 'standard';
}
