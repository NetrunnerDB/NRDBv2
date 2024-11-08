import Component from '@glimmer/component';
import CardLinkTo from '../card/link-to';
import Icon from '../icon';
import { get } from '@ember/helper';
import gt from 'ember-truth-helpers/helpers/gt';

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
                    <img
                      src='{{card.latestPrinting.largeImage}}'
                      alt={{card.title}}
                    />
                    {{#if (gt (get @decklist.cardSlots card.id) 1)}}
                      <img
                        src='{{card.latestPrinting.mediumImage}}'
                        alt={{card.title}}
                      />
                    {{/if}}
                    {{#if (gt (get @decklist.cardSlots card.id) 2)}}
                      <img
                        src='{{card.latestPrinting.tinyImage}}'
                        alt={{card.title}}
                      />
                    {{/if}}
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
