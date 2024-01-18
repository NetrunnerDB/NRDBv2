import Component from '@glimmer/component';

export default class InfluencePipsComponent extends Component {
  get influence() {
    let inf = '';
    for (let i = 0; i < this.args.printing.influenceCost; i++) {
      inf += '•';
    }
    return inf;
  }

  <template>
    <span class="influence influence-{{ @printing.factionId }}">{{ this.influence }}</span>
  </template>
}
