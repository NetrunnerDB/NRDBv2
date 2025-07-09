import { formatMessage } from 'ember-intl';
import CardLinkTo from '../card/link-to';
import { get } from '@ember/helper';
import Component from '@glimmer/component';

const CardList = <template>
  {{#if @cards.length}}
    <li>
      <strong>
        {{formatMessage
          '{amount, plural, one {# Point} other {# Points} }'
          amount=@amount
        }}
      </strong>
      <ul>
        {{#each @cards as |card|}}
          <li>
            <CardLinkTo @printing={{card}} class='text-truncate'>
              {{card.title}}
            </CardLinkTo>
          </li>
        {{/each}}
      </ul>
    </li>
  {{/if}}
</template>;

/**
 * Args:
 * @restriction - The restriction object containing corp points data.
 *
 */

export default class Points extends Component {
  get pointCategories() {
    let format = this.args.formats?.find(
      (f) => f.id === this.args.selectedFormat,
    );
    let restriction = format
      .hasMany('restrictions')
      .value()
      .find(({ id }) => id === this.args.restriction.id);

    let pointGroups = Object.groupBy(
      Object.entries(restriction.verdicts.points),
      ([, value]) => value,
    );
    let cardGroups = Object.entries(pointGroups)
      .map(([i, cards]) => [i, cards.map(([k]) => k)])
      .reverse();

    return cardGroups;
  }

  <template>
    {{#if @restriction.hasPoints}}
      {{#let (get @restriction @side) as |cards|}}
        <ul>
          <li>
            <strong>Points</strong>
            <ul>
              <CardList @amount='3' @cards={{cards.threePoints}} />
              <CardList @amount='2' @cards={{cards.twoPoints}} />
              <CardList @amount='1' @cards={{cards.onePoint}} />
            </ul>
          </li>
        </ul>
      {{/let}}
    {{/if}}
  </template>
}
