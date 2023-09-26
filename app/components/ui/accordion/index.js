import Component from '@glimmer/component';
import { action } from '@ember/object';
import { tracked as trackedBuiltin } from 'tracked-built-ins';
import { tracked } from '@glimmer/tracking';

export default class PanelListComponent extends Component {
  panels = trackedBuiltin([]);
  @tracked query = '';

  constructor() {
    super(...arguments);

    this.panels.push(...new Array(this.args.items.length).fill(false));
    this.panels[0] = !!this.args.expandFirstItem;
  }

  @action setAllPanels(value) {
    this.panels.fill(value);
  }

  @action togglePanel(panel) {
    this.panels[panel] = !this.panels[panel];
  }

  isPanelFiltered(query, property) {
    if (query.length === 0) {
      return false;
    }

    return !property.toLowerCase().includes(query);
  }
}
