import Component from '@glimmer/component';
import EmberPopover from 'ember-tooltips/components/ember-tooltip';
import TextBox from './text-box';
import { LinkTo } from '@ember/routing';
import { service } from '@ember/service';

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
      ...
    {{else}}
      <LinkTo @route="card" @model={{this.linkId}} ...attributes>
        {{yield}}
        {{#unless @hideTooltip}}
          <EmberPopover @tooltipClass="tippy-box" @event="hover">
            <TextBox
              @printing={{this.printing}}
              @showTitle={{true}}
              @showThumbnail={{true}}
            />
          </EmberPopover>
        {{/unless}}
      </LinkTo>
    {{/if}}
  </template>
}
