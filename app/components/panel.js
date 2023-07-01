import Ember from 'ember';
import Component from '@glimmer/component';
import { tracked } from '@glimmer/tracking';
import { action } from '@ember/object';
import { addListener } from '@ember/object/events';

export default class PanelComponent extends Component {
  @tracked show = false;
  @tracked filteredOut = false;

  constructor(owner, args) {
    super(owner, args);
    addListener(Ember.getOwner(this), 'showAll', this.showPanel);
    addListener(Ember.getOwner(this), 'hideAll', this.hidePanel);
    addListener(Ember.getOwner(this), 'filter', this.filter);
  }

  @action showPanel() {
    this.show = true;
  }
  @action hidePanel() {
    this.show = false;
  }
  @action togglePanel() {
    this.show = !this.show;
  }

  @action filter(query) {
    this.filteredOut = !this.args.title.toLowerCase().includes(query);
  }
}
