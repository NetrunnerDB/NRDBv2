import Component from '@glimmer/component';
import { Hyphenate } from 'netrunnerdb/helpers/hyphenate';
import { Range } from 'netrunnerdb/helpers/range';
import { not } from 'netrunnerdb/utils/template-operators';

export default class CardInfluencePips extends Component {
  constructor(...args) {
    super(...args);

    this.filled = this.args.count;
    this.empty = 5 - this.args.count;
  }

  <template>
    <span class='influence-pips'>
      <span class={{Hyphenate @factionId}}>
        {{#each (Range this.filled) as |_|}}●{{/each}}</span><span
        class='empty'
      >{{#unless @hideEmpty}}{{#each
            (Range this.empty)
            as |_|
          }}○{{/each}}{{/unless}}</span>
    </span>
  </template>
}
