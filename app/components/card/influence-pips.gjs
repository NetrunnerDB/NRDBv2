import Component from '@glimmer/component';
import { Hyphenate } from 'netrunnerdb/helpers/hyphenate';
import { Range } from 'netrunnerdb/helpers/range';
import { not } from 'netrunnerdb/utils/template-operators';

// Note: this.args.hideEmpty is effectively always true if this.args.repeat is set

export default class CardInfluencePips extends Component {
  constructor(...args) {
    super(...args);

    this.filled = this.args.count;
    this.empty = 5 - this.args.count;
  }

  mod = () => {
    return (this.args.count * this.args.repeat) % 5;
  };
  div = () => {
    return Math.floor((this.args.count * this.args.repeat) / 5);
  };

  <template>
    <span class='influence-pips {{Hyphenate @factionId}}'>
      {{#if @repeat}}
        {{#each (Range (this.div)) as |_|}}
          ●●●●●
        {{/each}}
        {{#each (Range (this.mod)) as |_|}}●{{/each}}
      {{else}}
        <span>
          {{#each (Range this.filled) as |_|}}●{{/each}}</span><span
          class='empty'
        >{{#unless @hideEmpty}}{{#each
              (Range this.empty)
              as |_|
            }}○{{/each}}{{/unless}}</span>
      {{/if}}
    </span>
  </template>
}
