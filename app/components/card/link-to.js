import { service } from '@ember/service';
import Component from '@glimmer/component';
import 'tippy.js/themes/light-border.css'; // Used in the link-to.hbs file

export default class CardLinkToComponent extends Component {
  @service store;

  get printing() {
    // If given a printing, return that
    if (this.args.printing) {
      return this.args.printing;
    }

    // If given a numeric id, get the printing with that id and return it
    if (this.args.id.match(/^\d+$/)) {
      return this.store.findRecord('printing', this.args.id);
    }

    // If given a generic string id, get the card with that id and return its latest printing
    // TODO: make this work
    return this.store
      .findRecord('card', this.args.id)
      .then((card) => this.store.findRecord('printing', card.latestPrintingId));
  }
}
