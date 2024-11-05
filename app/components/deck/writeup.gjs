import { and } from 'netrunnerdb/utils/template-operators';
import gt from 'ember-truth-helpers/helpers/gt';
import notEq from 'ember-truth-helpers/helpers/not-eq';
import Component from '@glimmer/component';
import Icon from '../icon';
import CardLinkTo from '../card/link-to';
import InfluencePips from '../card/influence-pips';

export default class Writeup extends Component {
  formatCards(cards, cardTypes, decklist) {
    let row1CardTypes = cardTypes.filter((type) =>
      [
        'agenda',
        'asset',
        'operation',
        'upgrade',
        'event',
        'hardware',
        'resource',
      ].includes(type.id),
    );
    let row2CardTypes = cardTypes.filter((type) =>
      ['ice', 'program'].includes(type.id),
    );

    let row1Cards = row1CardTypes.map((type) => {
      let cs = cards.filter((card) => card.cardTypeId == type.id);
      return {
        name: type.name,
        cardTypeId: type.id,
        cards: cs,
        count: this.countCards(cs, decklist),
      };
    });

    let row2Cards = [];
    row2CardTypes.forEach((type) => {
      if (type.id == 'ice') {
        let data = this.formatIce(cards);
        row2Cards.push({
          name: 'Barrier',
          cardTypeId: 'ice',
          cards: data.barriers,
          count: this.countCards(data.barriers, decklist),
        });
        row2Cards.push({
          name: 'Code Gate',
          cardTypeId: 'ice',
          cards: data.codeGates,
          count: this.countCards(data.codeGates, decklist),
        });
        row2Cards.push({
          name: 'Sentry',
          cardTypeId: 'ice',
          cards: data.sentries,
          count: this.countCards(data.sentries, decklist),
        });
        row2Cards.push({
          name: 'Multi',
          cardTypeId: 'ice',
          cards: data.multis,
          count: this.countCards(data.multis, decklist),
        });
        row2Cards.push({
          name: 'Other',
          cardTypeId: 'ice',
          cards: data.misc,
          count: this.countCards(data.misc, decklist),
        });
      } else {
        let data = this.formatPrograms(cards);
        row2Cards.push({
          name: 'Icebreaker',
          cardTypeId: 'program',
          cards: data.icebreakers,
          count: this.countCards(data.icebreakers, decklist),
        });
        row2Cards.push({
          name: 'Program',
          cardTypeId: 'program',
          cards: data.misc,
          count: this.countCards(data.misc, decklist),
        });
      }
    });

    return [row1Cards, row2Cards];
  }

  <template>
    <div class='row mt-4 ms-4'>
      {{#each @cards as |col|}}
        <div class='col-6'>
          {{#each col as |category|}}
            {{#if category.cards}}
              <p class='font-size-18'>
                <Icon @icon={{category.cardTypeId}} />
                {{category.name}}
                ({{category.count}})
              </p>
              <ul class='list-unstyled secondary mt-2'>
                {{#each category.cards as |card|}}
                  <li>
                    {{this.quantity card.id}}x
                    <CardLinkTo @printing={{card.printing}}>
                      {{card.title}}
                      {{#if
                        (and
                          (gt card.influenceCost 0)
                          (notEq card.factionId @decklist.factionId)
                        )
                      }}
                        {{! TODO: Alliance cards and neutral IDs }}
                        <InfluencePips
                          @factionId={{card.factionId}}
                          @count={{card.influenceCost}}
                          @hideEmpty='true'
                          @repeat={{this.quantity card.id}}
                        />
                      {{/if}}
                    </CardLinkTo>
                  </li>
                {{/each}}
              </ul>
            {{/if}}
          {{/each}}
        </div>
      {{/each}}
    </div>
  </template>
}
