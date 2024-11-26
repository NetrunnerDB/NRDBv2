import FaIcon from '@fortawesome/ember-fontawesome/components/fa-icon';
import { LinkTo } from '@ember/routing';
import { hash } from '@ember/helper';
import { htmlSafe } from '@ember/template';
import { and, eq } from 'netrunnerdb/utils/template-operators';
import Hyphenate from '../../utils/hyphenate';
import { TruncateFaction } from 'netrunnerdb/helpers/truncate-faction';
import { TruncateType } from 'netrunnerdb/helpers/truncate-type';

import Icon from '../icon';
import { SmallInfluencePips } from './influence-pips';
import Stats from './stats';
import Text from './text';

function backgroundImage(image) {
  return htmlSafe(`background-image: url(${image})`);
}

<template>
  <div class='game-card-text-box'>
    {{#if @showThumbnail}}
      <div class='hex'>
        <div class='hex-border'>
          <div class='hex-background'>
            {{! template-lint-disable style-concatenation }}
            <div
              class='hex-image thumbnail-{{Hyphenate @printing.cardTypeId}}{{if
                  (eq @printing.releasedBy "fantasy_flight_games")
                  "-ffg"
                }}'
              style={{backgroundImage @printing.images.nrdb_classic.small}}
            ></div>
          </div>
        </div>
      </div>
    {{/if}}
    {{#if @showTitle}}
      <div class='game-card-title font-size-20'>
        {{#if @printing.isUnique}}♦ {{/if}}{{@printing.title}}
      </div>
    {{/if}}
    <div class='game-card-details {{if @showThumbnail "me-4"}}'>
      <span class='game-card-type'>
        <b>{{TruncateType @printing.cardType.name}}:</b>
      </span>
      <span class='game-card-subtypes'>{{@printing.displaySubtypes}}</span>
      <span class='game-card-stats'><Stats @printing={{@printing}} /></span>
    </div>
    {{#if @printing.text}}
      <div class='game-card-text border-{{Hyphenate @printing.factionId}}'>
        <Text @text={{@printing.text}} />
      </div>
    {{/if}}
    {{#if @showFlavor}}
      {{#if @printing.flavor}}
        <div class='game-card-flavor'>
          {{htmlSafe @printing.flavor}}
        </div>
      {{/if}}
    {{/if}}
    <div class='game-card-footer'>
      <p>
        <span class='{{Hyphenate @printing.factionId}}'>
          <SmallInfluencePips @printing={{@printing}} /><Icon
            @icon={{@printing.factionId}}
          />
        </span>
        {{TruncateFaction @printing.faction.name}}
        •
        <Icon @icon={{@printing.cardCycleId}} />
        <LinkTo
          @route='set'
          @model='{{@printing.cardSet.id}}'
        >{{@printing.cardSet.name}}</LinkTo>
        •
        {{@printing.position}}
      </p>
    </div>
    {{#if @showIllustrators}}
      <div class='game-card-illustrator'>
        <p>
          Illustrated by
          {{#each @printing.illustratorNames as |name|}}
            <LinkTo
              @route='page.illustrators'
              @query={{hash search=name}}
            >{{name}}</LinkTo>
          {{/each}}
        </p>
      </div>
    {{/if}}
    {{#if @showProduction}}
      <div class='game-card-producer'>
        <p>
          {{#if
            (and
              (eq @printing.designedBy 'fantasy_flight_games')
              (eq @printing.releasedBy 'fantasy_flight_games')
            )
          }}
            <FaIcon @icon='fantasy-flight-games' @prefix='fab' />
            Designed & Released by Fantasy Flight Games
          {{else if
            (and
              (eq @printing.designedBy 'null_signal_games')
              (eq @printing.releasedBy 'null_signal_games')
            )
          }}
            {{! TODO: make a new named icon for nsg instead of reusing neutral-runner}}
            <Icon @icon='neutral-runner' />
            Designed & Released by Null Signal Games
          {{else if
            (and
              (eq @printing.designedBy 'fantasy_flight_games')
              (eq @printing.releasedBy 'null_signal_games')
            )
          }}
            <FaIcon @icon='fantasy-flight-games' @prefix='fab' />
            Designed by Fantasy Flight Games.
            <br />
            {{! TODO: make a new named icon for nsg instead of reusing neutral-runner}}
            <Icon @icon='neutral-runner' />
            Released by Null Signal Games.
          {{/if}}
        </p>
      </div>
    {{/if}}
  </div>
</template>
