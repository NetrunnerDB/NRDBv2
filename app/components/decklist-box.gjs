import Component from '@glimmer/component';
import { tracked } from '@glimmer/tracking';
import { LinkTo } from '@ember/routing';
import { service } from '@ember/service';
import { Hyphenate } from '../helpers/hyphenate';
import {
  GetIdentityTitle,
  GetIdentitySubtitle,
} from '../helpers/split-identity-name';
import Icon from './icon';
import { sub } from 'netrunnerdb/utils/template-operators';

export default class DecklistBoxComponent extends Component {
  @service store;
  @tracked identityPrinting;

  constructor(...args) {
    super(...args);

    this.init();
  }

  async init() {
    let identityCardId = this.args.decklist.identityCardId;
    let userId = this.args.decklist.userId;
    let cardIds = this.args.decklist.cards;

    this.identityCard = this.store.findRecord('card', identityCardId, {
      include: 'printings',
    });
    this.identityPrinting = await this.identityCard.then(function (card) {
      return card.printings.find((p) => p.id == card.latestPrintingId);
    });
    this.user = userId; // TEMP
  }

  <template>
    <div class='decklist-box'>
      <div class='row mx-2'>
        <div class='col-4 visible-lg'>
          <img
            class='decklist-identity'
            src={{this.identityPrinting.images.nrdb_classic.large}}
          />
        </div>
        <div class='col-8 decklist-stats'>
          <p class='font-size-26'>{{@decklist.name}}</p>
          <p class='decklist-identity-name'>
            <span class='decklist-identity-title font-size-24'>
              <Icon @icon={{@decklist.factionId}} />
              {{GetIdentityTitle this.identityCard.title}}
            </span>
            <span class='decklist-identity-subtitle fontsize-22'>
              {{GetIdentitySubtitle this.identityCard.title}}
            </span>
          </p>
          <p class='decklist-influence'>
            {{@decklist.influenceSpent}}
            influence spent (max
            {{this.identityCard.influenceLimit}}, available
            {{sub this.identityCard.influenceLimit @decklist.influenceSpent}})
          </p>
          <p class='decklist-cards'>
            {{@decklist.numCards}}
            cards (min
            {{this.identityCard.minimumDeckSize}})
          </p>
          <p class='decklist-set'>
            Cards up to The Automata Initiative
          </p>
          <p class='decklist-author font-size-16'>
            Author:
            {{this.user}}
            (1187)
          </p>
          <LinkTo @route='home' class='button decklist-box-button'>
            <Icon @icon='subroutine' />
            View deck
          </LinkTo>
        </div>
      </div>
    </div>
  </template>
}
