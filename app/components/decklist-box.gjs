import Component from '@glimmer/component';
import { tracked } from '@glimmer/tracking';
import { LinkTo } from '@ember/routing';
import { service } from '@ember/service';
import FaIcon from '@fortawesome/ember-fontawesome/components/fa-icon';
import {
  GetIdentityTitle,
  GetIdentitySubtitle,
} from '../helpers/split-identity-name';
import CardLinkTo from './card/link-to';
import Icon from './icon';
import { sub } from 'netrunnerdb/utils/template-operators';

export default class DecklistBoxComponent extends Component {
  @service store;
  @tracked identityPrinting;

  constructor(...args) {
    super(...args);

    this.loadPrinting(this.args.decklist);
  }

  async loadPrinting(decklist) {
    let identityCardId = decklist.identityCardId;

    this.identityCard = await this.store.findRecord('card', identityCardId, {
      include: 'printings',
    });
    this.identityPrinting = this.identityCard.printings.find(
      (p) => p.id == this.identityCard.latestPrintingId,
    );
  }

  <template>
    <div class='decklist-box'>
      <div class='d-flex mx-2'>
        <div class='visible-lg' style='width:200px'>
          <img
            alt={{this.identityPrinting.title}}
            class='decklist-identity game-card'
            src={{this.identityPrinting.images.nrdb_classic.large}}
          />
        </div>
        <div class='decklist-stats ms-4'>
          {{#if @showTitle}}
            <p class='font-size-26'>{{@decklist.name}}</p>
          {{/if}}
          {{#if this.identityPrinting}}
            <p class='decklist-identity-name'>
              <CardLinkTo @printing={{this.identityPrinting}}>
                <span class='decklist-identity-title font-size-24'>
                  <Icon @icon={{@decklist.factionId}} />
                  {{GetIdentityTitle this.identityCard.title}}
                </span>
                <span class='decklist-identity-subtitle fontsize-22'>
                  {{GetIdentitySubtitle this.identityCard.title}}
                </span>
              </CardLinkTo>
            </p>
          {{/if}}
          <p class='decklist-influence'>
            {{@decklist.influenceSpent}}
            influence spent (max
            {{@decklist.identityCard.influenceLimit}}, available
            {{sub
              @decklist.identityCard.influenceLimit
              @decklist.influenceSpent
            }})
          </p>
          <p class='decklist-cards'>
            <FaIcon @icon='cards-blank' @flip='horizontal' />
            {{@decklist.numCards}}
            cards (min
            {{@decklist.identityCard.minimumDeckSize}})
          </p>
          <p class='decklist-set'>
            Cards up to The Automata Initiative
          </p>
          {{#if @showAuthor}}
            <p class='decklist-author font-size-16'>
              Author:
              {{@decklist.author.username}}
              (1187)
            </p>
          {{/if}}
          {{#if @showLink}}
            <LinkTo
              @route='decklist'
              @model={{@decklist.id}}
              class='button decklist-box-button'
            >
              <Icon @icon='subroutine' />
              View deck
            </LinkTo>
          {{/if}}
        </div>
      </div>
    </div>
  </template>
}
