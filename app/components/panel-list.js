import Component from '@glimmer/component';
import { action } from '@ember/object';
import { sendEvent } from '@ember/object/events';
import { getOwner } from '@ember/application';

export default class PanelListComponent extends Component {
  query = '';

  @action showAll() {
    sendEvent(getOwner(this), 'showAll');
  }
  @action hideAll() {
    sendEvent(getOwner(this), 'hideAll');
  }

  @action filter() {
    sendEvent(getOwner(this), 'filter', [this.query.toLowerCase()]);
  }
}
