import Component from '@glimmer/component';
import { LinkTo } from '@ember/routing';
import { service } from '@ember/service';
import { Hyphenate } from '../helpers/hyphenate';
import Icon from './icon';

export default class DecklistBoxLinkComponent extends Component {
  @service store;

  constructor(...args) {
    super(...args);

    this.factionId = this.args.decklist.factionId;
    this.user = this.args.decklist.userId; // TEMP
    this.karma = 1337; // TEMP
  }
  <template>
    <LinkTo
      @route='decklist'
      @model={{this.args.decklist}}
      class='decklist-box-link mt-2'
    >
      <div class='row px-3' style='height:70px'>
        <div class='col-1 col-lg-2 position-relative font-size-32'>
          <div
            class='decklist-link-faction position-absolute w-75'
            style='top:50%; transform:translateY(calc(-50% - 4px))'
          >
            <Icon @icon='{{Hyphenate this.factionId}}' />
          </div>
        </div>
        <div class='col-11 col-lg-10 position-relative font-size-14'>
          <div
            class='position-absolute w-75'
            style='top:50%; transform:translateY(-50%)'
          >
            <div class='text-truncate'><b>{{@decklist.name}}</b></div>
            <div class='text-truncate'>{{this.user}} ({{this.karma}})</div>
          </div>
        </div>
      </div>
    </LinkTo>
  </template>
}
