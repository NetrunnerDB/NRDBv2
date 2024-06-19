import { LinkTo } from '@ember/routing';
import { or, eq, notEmpty, maybe } from 'netrunnerdb/utils/template-operators';
import { Hyphenate } from 'netrunnerdb/helpers/hyphenate';
import { TruncateType } from 'netrunnerdb/helpers/truncate-type';
import Icon from '../icon';
import Image from './image';
import InfluencePips from './influence-pips';
import Text from './text';
import TextBox from './text-box';
import Legality from './legality';
import LinkToCard from './link-to';

<template>
  <div class='flex-grow-1' id='nav-main-content'>
    <div class='row'>

      {{! IMAGE }}
      <div class='col-md-2'>
        <Image src={{@printing.images.nrdb_classic.large}} />
        {{#if false}}
          {{! Re-enable this with a check on if this is a flip card when the API supports those explicitly. }}
          <div class='d-flex justify-content-center mt-3'>
            <button id='flip' type='button' class='btn btn-secondary'><i
                class='fa-solid fa-rotate'
              ></i>
              Flip</button>
          </div>
        {{/if}}
      </div>

      {{! STATS }}
      <div class='col-md-6 pe-md-4'>
        <table class='game-card-stats'>
          <tbody>
            <tr>
              <td>Type</td>
              <td>{{TruncateType @printing.cardType.name}}</td>
            </tr>
            <tr>
              <td>Subtypes</td>
              <td>{{if
                  @printing.displaySubtypes
                  @printing.displaySubtypes
                  '–'
                }}</td>
            </tr>
            <tr>
              <td>Faction</td>
              <td>
                <Icon @icon={{@printing.faction.id}} />
                {{@printing.faction.name}}
              </td>
            </tr>
            {{#if
              (or
                (eq @printing.cardTypeId 'corp_identity')
                (eq @printing.cardTypeId 'runner_identity')
              )
            }}
              <tr>
                <td>Minimum deck size</td>
                <td>{{@printing.minimumDeckSize}}</td>
              </tr>
              <tr>
                <td>Influence limit</td>
                <td>{{@printing.influenceLimit}}</td>
              </tr>
            {{else}}
              <tr>
                <td>Influence</td>
                <td>
                  <InfluencePips
                    @factionId={{Hyphenate @printing.factionId}}
                    @count={{@printing.influenceCost}}
                    @hideEmpty={{true}}
                  />
                  {{if @printing.influenceCost @printing.influenceCost '–'}}
                </td>
              </tr>
            {{/if}}
            {{#if (notEmpty @printing.cost)}}
              <tr>
                <td>Cost</td>
                <td>
                  <Icon @icon='credit' />
                  {{@printing.cost}}
                </td>
              </tr>
            {{else if (notEmpty @printing.advancementRequirement)}}
              <tr>
                <td>Advancement requirement</td>
                <td>
                  {{@printing.advancementRequirement}}
                </td>
              </tr>
            {{/if}}
            {{#if (notEmpty @printing.agendaPoints)}}
              <tr>
                <td>Agenda points</td>
                <td>
                  <Icon @icon='agenda-points' />
                  {{@printing.agendaPoints}}
                </td>
              </tr>
            {{else if (notEmpty @printing.trashCost)}}
              <tr>
                <td>Trash cost</td>
                <td>
                  <Icon @icon='trash-cost' />
                  {{@printing.trashCost}}
                </td>
              </tr>
            {{/if}}
            {{#if (notEmpty @printing.memoryCost)}}
              <tr>
                <td>Memory</td>
                <td>{{@printing.memoryCost}}</td>
              </tr>
            {{/if}}
            {{#if (notEmpty @printing.strength)}}
              <tr>
                <td>Strength</td>
                <td>{{@printing.strength}} <Icon @icon='strength' /></td>
              </tr>
            {{else if (eq @printing.cardTypeId 'program')}}
              <tr>
                <td>Strength</td>
                <td>- <Icon @icon='strength' /></td>
              </tr>
            {{/if}}
          </tbody>
        </table>

        <div class='mt-2'>
          <Text @text={{@printing.text}} />
          {{#if @printing.flavor}}
            <p class='game-card-flavor secondary mt-2'>
              <i>{{@printing.flavor}}</i>
            </p>
          {{/if}}
          <p class='mt-2'>
            <b>Illustrated by {{@printing.displayIllustrators}}</b>
          </p>
          {{#if @printing.attribution}}
            <p class='mt-2'>
              <b>{{@printing.attribution}}</b>
            </p>
          {{/if}}
          <LinkTo @route='home' class='button blue mt-3'>
            <Icon @icon='subroutine' />
            Decks with this card
          </LinkTo>
        </div>
      </div>

      {{! SETS }}
      <div class='col-md-4'>
        <div class='card game-card-card'>
          <div class='card-header'>
            <Icon @icon={{Hyphenate @printing.cardSet.cardCycleId}} />
            {{@printing.cardSet.name}}
            <div class='font-size-14 secondary'>
              #{{@printing.position}}
              • English
            </div>
          </div>
          <ul class='list-group list-group-flush'>
            <li class='list-group-item'>
              Legality
              <div id='legalities' class='mt-1'>
                <div class='mt-1'>
                  <Legality
                    @printing={{@printing}}
                    @format='startup'
                    @snapshot={{@startupSnapshot}}
                  >
                    Startup card pool</Legality>
                </div>
                <div class='mt-1'>
                  <Legality
                    @printing={{@printing}}
                    @format='standard'
                    @snapshot={{@standardSnapshot}}
                  >
                    Standard card pool</Legality>
                </div>
                <div class='mt-1'>
                  <Legality
                    @printing={{@printing}}
                    @format='eternal'
                    @snapshot={{@eternalSnapshot}}
                  >
                    Eternal card pool</Legality>
                </div>
              </div>
              <div class='mt-1'>
                <LinkTo @model={{@model}}>Show history</LinkTo>
              </div>
            </li>
            <li class='list-group-item'>
              Printings
              {{#each @allPrintings as |printing|}}
                <p>
                  <Icon @icon={{printing.cardCycle.id}} />
                  <LinkToCard @id={{printing.id}} @hideTooltip={{true}}>
                    {{printing.cardSet.name}}
                  </LinkToCard>
                </p>
              {{/each}}
            </li>
          </ul>
        </div>
      </div>
    </div>
  </div>
</template>
