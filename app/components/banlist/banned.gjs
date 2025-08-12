import Component from '@glimmer/component';
import CardLinkTo from '../card/link-to';

const capitalize = 'text-transform: capitalize';

export default class Banned extends Component {
  get bannedCards() {
    return this.args.restriction.verdicts.banned
      .map((cardId) => {
        return this.args.cards.get(cardId);
      })
      .filter((card) => {
        return card && card.sideId === this.args.side;
      });
  }

  <template>
    <ul>
      <li>
        <strong>Banned</strong>
        ({{this.bannedCards.length}})

        <ul>
          {{#if @restriction.bannedSubtypes.length}}
            {{! TODO: have those cards here, but collapsed by default }}
            <li>
              All Cards With Subtype:
              {{#each @restriction.bannedSubtypes as |subtype|~}}
                <strong style={{capitalize}}>{{subtype}}</strong>
              {{~/each}}
            </li>
          {{/if}}

          {{#each this.bannedCards as |card|}}
            <li>
              <CardLinkTo @printing={{card}} class="text-truncate">
                {{card.title}}
              </CardLinkTo>
            </li>
          {{/each}}
        </ul>
      </li>
    </ul>
  </template>
}
