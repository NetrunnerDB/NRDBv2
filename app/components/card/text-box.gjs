import FaIcon from '@fortawesome/ember-fontawesome/components/fa-icon';
import { LinkTo } from '@ember/routing';
import { hash } from '@ember/helper';
import { htmlSafe } from '@ember/template';
import { and, eq } from 'netrunnerdb/utils/template-operators';

import Icon from '../icon';
import InfluencePips from './influence-pips';
import Stats from './stats';
import Text from './text';

function backgroundImage(printing) {
  return htmlSafe(
    `background-image: url(${printing.images.nrdb_classic.small})`,
  );
}

<template>
  <div class='card-text-box'>
    {{#if @showThumbnail}}
      <div class='hex'>
        <div class='hex-border'>
          <div class='hex-background'>
            {{! template-lint-disable no-inline-styles }}
            {{! template-lint-disable style-concatenation }}
            <div
              class='hex-image thumbnail-{{@printing.cardTypeId}}'
              style={{backgroundImage @printing}}
            ></div>
          </div>
        </div>
      </div>
    {{/if}}
    {{#if @showTitle}}
      <div class='card-title'>
        {{#if @printing.isUnique}}♦ {{/if}}{{@printing.title}}
      </div>
    {{/if}}
    <div class='card-details'>
      <span class='card-type'><b>{{@printing.cardType.name}}:</b></span>
      <span class='card-subtypes'>{{@printing.displaySubtypes}}</span>
      <span class='card-stats'><Stats @printing={{@printing}} /></span>
    </div>
    {{#if @printing.text}}
      <div class='card-text border-{{@printing.factionId}}'>
        <Text @text={{@printing.text}} />
      </div>
    {{/if}}
    {{#if @showFlavor}}
      {{#if @printing.flavor}}
        <div class='card-flavor'>
          {{htmlSafe @printing.flavor}}
        </div>
      {{/if}}
    {{/if}}
    <div>
      <p>
        <InfluencePips @printing={{@printing}} /><Icon
          @icon={{@printing.factionId}}
        />
        {{@printing.faction.name}}
        •
        <Icon @icon={{@printing.cardSetId}} />
        <LinkTo
          @route='page.set'
          @model='{{@printing.cardSet.id}}'
        >{{@printing.cardSet.name}}</LinkTo>
        {{@printing.position}}
      </p>
    </div>
    {{#if @showIllustrators}}
      <div class='card-illustrator'>
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
      <div class='card-producer'>
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
