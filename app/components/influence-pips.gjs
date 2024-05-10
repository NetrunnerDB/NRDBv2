import Component from '@glimmer/component';
import { Hyphenate } from '../helpers/hyphenate';
import { Range } from '../helpers/range';

class InfluencePips extends Component {
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
      >{{#each (Range this.empty) as |_|}}○{{/each}}</span>
    </span>
  </template>
}

export default InfluencePips;
