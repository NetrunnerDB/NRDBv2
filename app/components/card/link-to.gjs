import { service } from '@ember/service';
import Component from '@glimmer/component';
import { LinkTo } from '@ember/routing';
import Tippy from 'ember-tippy/components/tippy';
import 'tippy.js/themes/light-border.css'; // Used in the link-to.hbs file

import TextBox from './text-box';

export default class CardLinkToComponent extends Component {
  @service store;

  get linkId() {
    if (this.args.id) {
      return this.args.id;
    }

    return this.args.printing.id;
  }

  get printing() {
    // If given a printing, return that
    if (this.args.printing) {
      return this.args.printing;
    }

    // If given a numeric id, get the printing with that id and return it
    if (this.args.id?.match(/^\d+$/)) {
      return this.store.findRecord('printing', this.args.id);
    }

    // If given a generic string id, get the card with that id and return its latest printing
    // TODO: make this work
    return this.store
      .findRecord('card', this.args.id)
      .then((card) => this.store.findRecord('printing', card.latestPrintingId));
  }

  <template>
    {{#if this.printing.isPending}}
      LOADING...
    {{else}}
      <LinkTo @route="page.card" @model={{this.linkId}} ...attributes>
        {{yield}}
        {{#unless @hideTooltip}}
          <Tippy @placement="auto" @theme="light-border">
            <TextBox
              @printing={{this.printing}}
              @showTitle={{true}}
              @showThumbnail={{true}}
            />
          </Tippy>
        {{/unless}}
      </LinkTo>
    {{/if}}
  </template>
}
