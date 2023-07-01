import Ember from 'ember';
import Component from '@glimmer/component';
import { tracked } from '@glimmer/tracking';
import { action } from '@ember/object';
import { sendEvent } from '@ember/object/events';

export default class PanelListComponent extends Component {
  query = '';

  @action showAll() {
    sendEvent(Ember.getOwner(this), 'showAll');
  }
  @action hideAll() {
    sendEvent(Ember.getOwner(this), 'hideAll');
  }

  @action filter() {
    sendEvent(Ember.getOwner(this), 'filter', [this.query.toLowerCase()]);
  }
}
