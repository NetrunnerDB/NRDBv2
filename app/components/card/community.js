import Component from '@glimmer/component';
import { tracked } from '@glimmer/tracking';
import { action } from '@ember/object';

export default class CardCommunityComponent extends Component {
  @tracked tab = 'content-rulings';

  @action setTab(tabId) {
    this.tab = tabId;
  }
}
