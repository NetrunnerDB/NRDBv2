import Component from '@glimmer/component';

export default class CardImageComponent extends Component {
  get src() {
    const printing = this.args.card
      ? this.args.card.printings[0]
      : this.args.printing;
    const size = this.args.size ?? 'medium';

    return printing ? printing.images.nrdb_classic[size] : '';
  }

  <template>
    <div>
      {{#if this.src}}
        <img class="game-card card-art w-100" src={{this.src}} ...attributes />
      {{else}}
        <img class="game-card card-art w-100" ...attributes />
      {{/if}}
    </div>
  </template>
}
