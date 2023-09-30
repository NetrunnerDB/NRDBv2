import Controller from '@ember/controller';
import { tracked } from '@glimmer/tracking';

export default class BanlistsController extends Controller {
  queryParams = ['format', 'search'];

  @tracked format = 'standard';
}
