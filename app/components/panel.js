import Component from '@glimmer/component';
import { tracked } from '@glimmer/tracking';
import { action } from '@ember/object';
import { addListener } from '@ember/object/events';
import { getOwner } from '@ember/application';

export default class PanelComponent extends Component {
  @tracked filteredOut = false;

  constructor(owner, args) {
    super(owner, args);
    addListener(getOwner(this), 'showAll', this.showPanel);
    addListener(getOwner(this), 'hideAll', this.hidePanel);
    addListener(getOwner(this), 'filter', this.filter);
  }

  @action togglePanel() {
    if (this.args.isOpen) {
      this.args.hidePanel();
    } else {
      this.args.showPanel();
    }
  }

  @action filter(query) {
    this.filteredOut = !this.args.title.toLowerCase().includes(query);
  }
}
