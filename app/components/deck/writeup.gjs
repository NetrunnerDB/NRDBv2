import Component from '@glimmer/component';
import { get } from '@ember/helper';
import { and } from 'netrunnerdb/utils/template-operators';
import gt from 'ember-truth-helpers/helpers/gt';
import notEq from 'ember-truth-helpers/helpers/not-eq';
import Icon from '../icon';
import CardLinkTo from '../card/link-to';
import InfluencePips from '../card/influence-pips';

export default class Writeup extends Component {
  // Sorts a decklist's cards into an array of arrays of objects:
  // [[{
  //   name
  //   cardTypeId
  //   cards
  //   count
  // }]]
  // Each top level array represents a column on the decklist view
  // Each nested array represents the types (or subtypes) of cards within each subtype
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

  // Counts the number of individual cards in a decklist are from a list of distinct cards
  countCards(cards, decklist) {
    let count = 0;
    cards.forEach((card) => {
      count += decklist.cardSlots[card.id];
    });
    return count;
  }

  // Collect the ice from a list of cards and separate them by subtype
  formatIce(cards) {
    cards = cards.filter((card) => card.cardTypeId == 'ice');

    let barriers = [];
    let codeGates = [];
    let sentries = [];
    let multis = [];
    let misc = [];

    cards.forEach((card) => {
      let isBarrier = card.cardSubtypeIds.includes('barrier');
      let isCodeGate = card.cardSubtypeIds.includes('code_gate');
      let isSentry = card.cardSubtypeIds.includes('sentry');

      if (
        (isBarrier && isCodeGate) ||
        (isBarrier && isSentry) ||
        (isCodeGate && isSentry)
      ) {
        multis.push(card);
      } else if (isBarrier) {
        barriers.push(card);
      } else if (isCodeGate) {
        codeGates.push(card);
      } else if (isSentry) {
        sentries.push(card);
      } else {
        misc.push(card);
      }
    });

    return { barriers, codeGates, sentries, multis, misc };
  }

  // Collect the programs from a list of cards and separate them by icebreaker vs non-icebreaker
  formatPrograms(cards) {
    cards = cards.filter((card) => card.cardTypeId == 'program');

    let icebreakers = cards.filter((card) =>
      card.cardSubtypeIds.includes('icebreaker'),
    );
    let misc = cards.filter(
      (card) => !card.cardSubtypeIds.includes('icebreaker'),
    );

    return { icebreakers, misc };
  }

  get cardsByCategory() {
    return this.formatCards(
      this.args.decklist.cards,
      this.args.cardTypes,
      this.args.decklist,
    );
  }

  <template>
    <div class='row mt-4 ms-4'>
      {{#each this.cardsByCategory as |col|}}
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
                    {{get @decklist.cardSlots card.id}}&times;
                    <CardLinkTo
                      @printing={{card.latestPrinting}}
                      @card={{card}}
                    >
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
