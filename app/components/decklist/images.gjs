import Component from '@glimmer/component';
import CardLinkTo from '../card/link-to';
import Icon from '../icon';
import { get } from '@ember/helper';
import { Range } from 'netrunnerdb/helpers/range';

export default class DecklistImages extends Component {
  cardsByType = (cardType) => {
    let cards = this.args.decklist.cards;

    return cards.filter(({ cardTypeId }) => cardTypeId === cardType);
  };

  countByType = (cardType) => {
    let cardSlots = this.args.decklist.cardSlots;

    return this.cardsByType(cardType)
      .map((card) => cardSlots[card.id])
      .reduce((acc, i) => acc + i);
  };

  <template>
    {{#each @cardTypes as |type|}}
      {{#let (this.cardsByType type.id) as |cards|}}
        {{#if cards}}
          <h3 class='mt-4 font-size-20'>
            <Icon @icon='{{type.id}}' />
            {{type.name}}
            ({{this.countByType type.id}})
          </h3>
          <div class='row row-cols-8 g-3'>
            {{#each cards as |card|}}
              <div class='col'>
                <CardLinkTo @printing={{card.latestPrinting}}>
                  <div class='decklist-card'>
                    {{#each (Range (get @decklist.cardSlots card.id))}}
                      <img
                        src='{{card.latestPrinting.largeImage}}'
                        alt={{card.title}}
                      />
                    {{/each}}
                  </div>
                </CardLinkTo>
              </div>
            {{/each}}
          </div>
        {{/if}}
      {{/let}}
    {{/each}}
  </template>
}
