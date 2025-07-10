import { formatMessage } from 'ember-intl';
import CardLinkTo from '../card/link-to';
import Component from '@glimmer/component';
import { service } from '@ember/service';
import { cached } from '@glimmer/tracking';

export default class Points extends Component {
  @service store;

  @cached
  get pointCategories() {
    let pointGroups = Object.groupBy(
      Object.entries(this.args.restriction.verdicts.points),
      ([, pointValue]) => pointValue,
    );

    let cardGroups = Object.entries(pointGroups)
      .map(([i, cards]) => [
        i,
        cards
          .map(([cardId]) => this.store.peekRecord('card', cardId))
          .filter((card) => card.sideId === this.args.side),
      ])
      .reverse();

    return new Map(cardGroups);
  }

  <template>
    <ul>
      <li>
        <strong>Points</strong>
        <ul>
          {{#each-in this.pointCategories as |points cards|}}
            {{#if cards.length}}
              <li>
                <strong>
                  {{formatMessage
                    '{amount, plural, one {# Point} other {# Points} }'
                    amount=points
                  }}
                </strong>
                <ul>
                  {{#each cards as |card|}}
                    <li>
                      <CardLinkTo @printing={{card}} class='text-truncate'>
                        {{card.title}}
                      </CardLinkTo>
                    </li>
                  {{/each}}
                </ul>
              </li>
            {{/if}}
          {{/each-in}}
        </ul>
      </li>
    </ul>
  </template>
}
