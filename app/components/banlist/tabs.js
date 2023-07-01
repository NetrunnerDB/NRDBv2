import Component from '@glimmer/component';
import { tracked } from '@glimmer/tracking';
import { action } from '@ember/object';

export default class BanlistTabsComponent extends Component {
  @tracked tab = 'standard';

  @action setTab(tabId) {
    this.tab = tabId;
  }
}
