import FaIcon from '@fortawesome/ember-fontawesome/components/fa-icon';
import { LinkTo } from '@ember/routing';
import { hash } from '@ember/helper';
import { htmlSafe } from '@ember/template';

import Icon from '../icon';
import Stats from './stats';
import Text from './text';

<template>
  <div class="card-text-box">
    {{#if @showThumbnail}}
      <div class="hex">
        <div class="hex-border">
          <div class="hex-background">
            {{! template-lint-disable no-inline-styles }}
            {{! template-lint-disable style-concatenation }}
            <div
              class="hex-image thumbnail-{{@printing.cardTypeId}}"
              style="background-image: url({{@printing.images.nrdb_classic.small}})"
            ></div>
          </div>
        </div>
      </div>
    {{/if}}
    {{#if @showTitle}}
      <div class="card-title">
        {{#if @printing.isUnique}}♦ {{/if}}{{@printing.title}}
      </div>
    {{/if}}
    <div class="card-details">
      <span class="card-type"><b>{{@cardType.name}}:</b></span>
      <span class="card-subtypes">{{@printing.displaySubtypes}}</span>
      <span class="card-stats"><Stats @printing={{@printing}} /></span>
    </div>
    {{#if @printing.text}}
      <div class="card-text border-{{@printing.factionId}}">
        <Text @text={{@printing.text}} />
      </div>
    {{/if}}
    {{#if @showFlavor}}
      {{#if @printing.flavor}}
        <div class="card-flavor">
          {{htmlSafe @printing.flavor}}
        </div>
      {{/if}}
    {{/if}}
    <div class="card-illustrator">
      <p>
        <Icon @id={{@printing.factionId}} />
        {{@faction.name}}
        {{#each @printing.illustratorNames as |name|}}
          <LinkTo @route="page.illustrators" @query={{ hash search=name}}>{{name}}</LinkTo>
        {{/each}}•
        <Icon @id={{@printing.cardSetId}} />
        {{@cardSet.name}}
        {{@printing.position}}
      </p>
    </div>
    {{#if @showProduction}}
      <div class="card-producer">
        {{! TODO: once this data is available in the API make this show cards designed or reprinted by NSG }}
        <p><FaIcon @icon="fantasy-flight-games" @prefix="fab" />
          Designed and printed by FFG.</p>
      </div>
    {{/if}}
  </div>
</template>
