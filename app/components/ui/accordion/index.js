import Component from '@glimmer/component';
import { action } from '@ember/object';
import { tracked as trackedBuiltin } from 'tracked-built-ins';
import { service } from '@ember/service';

export default class PanelListComponent extends Component {
  @service router;

  panels = trackedBuiltin([]);

  constructor() {
    super(...arguments);

    this.panels.push(...new Array(this.args.items.length).fill(false));
    this.panels[0] = !!this.args.expandFirstItem;
  }

  get query() {
    return this.args.query ?? '';
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

    return !property.toLowerCase().includes(query.toLowerCase());
  }

  @action updateFilter({ target: { value: search } }) {
    this.router.transitionTo({ queryParams: { search } });
  }
}
