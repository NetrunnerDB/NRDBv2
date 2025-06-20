import Component from '@glimmer/component';
import { htmlSafe } from '@ember/template';
import { LinkTo } from '@ember/routing';
import { on } from '@ember/modifier';
import { get } from '@ember/helper';
import { hash } from '@ember/helper';
import { pageTitle } from 'ember-page-title';
import FaIcon from '@fortawesome/ember-fontawesome/components/fa-icon';
import {
  faHeart,
  faStar,
  faComment,
  faCodeCompare,
  faTableList,
  faSort,
  faImages,
  faDownload,
  faAlignLeft,
  faFileCode,
} from '@fortawesome/free-solid-svg-icons';
import formatISO8601Date from '../helpers/format-iso8601-date';

import and from 'ember-truth-helpers/helpers/and';
import notEq from 'ember-truth-helpers/helpers/not-eq';
import gt from 'ember-truth-helpers/helpers/gt';
import eq from 'ember-truth-helpers/helpers/eq';

import Navbar from 'netrunnerdb/components/navbar';
import Icon from 'netrunnerdb/components/icon';
import DecklistBox from 'netrunnerdb/components/decklist-box';
import DeckWriteup from 'netrunnerdb/components/deck/writeup';
import CardList from 'netrunnerdb/components/card/list';
import DecklistImages from 'netrunnerdb/components/decklist/images';

export default class DecklistComponent extends Component {
  displayHtml(source) {
    return htmlSafe(source);
  }

  constructor(...args) {
    super(...args);

    // TODO: set initial value of displayType to the current user's default preference
  }

  <template>
    {{pageTitle @model.decklist.name}}

    <main class='pb-4'>
      <Navbar />

      {{! HEADER - Custom rather than TitleBox }}
      <div class='decklist-banner'>
        <div class='container'>
          <div class='decklist-banner-data d-flex'>
            <div class='mt-auto'>
              <h1><Icon @icon='shaper' /><b>{{@model.decklist.name}}</b></h1>
              <div>
                <span class='decklist-banner-stat'>
                  By
                  <LinkTo @route='home'>{{@model.decklist.userId}}</LinkTo>
                </span>
                <span class='decklist-banner-stat ms-4'>
                  {{formatISO8601Date @model.decklist.createdAt}}
                </span>
                <span class='decklist-banner-stat ms-4'>
                  <FaIcon @icon={{faHeart}} @prefix='far' />
                  25
                </span>
                <span class='decklist-banner-stat ms-4'>
                  <FaIcon @icon={{faStar}} @prefix='far' />
                  12
                </span>
                <span class='decklist-banner-stat ms-4'>
                  <FaIcon @icon={{faComment}} @prefix='far' />
                  6
                </span>
              </div>
            </div>
          </div>
        </div>
      </div>

      {{! BODY }}
      <div class='container'>

        {{! WARNING }}
        {{#unless @model.decklist.followsBasicDeckbuildingRules}}
          <div class='warning-box mt-4'>
            This decklist is not legal for tournament play currently, due to
            Card Errata, Rotation or Legality.
          </div>
        {{/unless}}

        {{! BUTTONS }}
        <div class='row mt-4'>
          <div class='col-6'>
            <LinkTo @route='home' class='button'>Decklist</LinkTo>
            <LinkTo @route='home' class='button'>Sets</LinkTo>
            <LinkTo @route='home' class='button'>Info</LinkTo>
            <LinkTo @route='home' class='button'>Actions</LinkTo>
          </div>
          <div class='col-6 text-end'>
            <LinkTo @route='home' class='button'>
              <FaIcon @icon={{faFileCode}} @prefix='far' />
            </LinkTo>
            <LinkTo @route='home' class='button'>
              <FaIcon @icon={{faDownload}} />
            </LinkTo>
            <LinkTo @route='home' class='button'>
              <FaIcon @icon={{faCodeCompare}} />
            </LinkTo>
            <LinkTo @route='home' class='button'>
              <FaIcon @icon={{faSort}} />
              Sort
            </LinkTo>

            <div class='btn-group' role='group'>
              <LinkTo @query={{hash display='writeup'}} class='button'>
                <FaIcon @icon={{faAlignLeft}} />
              </LinkTo>
              <LinkTo @query={{hash display='list'}} class='button'>
                <FaIcon
                  @icon={{faTableList}}
                  @prefix='far'
                  @flip='horizontal'
                />
              </LinkTo>
              <LinkTo @query={{hash display='images'}} class='button'>
                <FaIcon @icon={{faImages}} @prefix='far' />
              </LinkTo>
            </div>
          </div>
        </div>

        {{! DECKLIST BOX }}
        <div class='row'>
          <div class='col-6'>
            <DecklistBox @decklist={{@model.decklist}} />
            {{#if (eq @controller.display 'writeup')}}
              <DeckWriteup
                @decklist={{@model.decklist}}
                @cardTypes={{@model.cardTypes}}
              />
            {{/if}}
          </div>

          <div class='col-6 position-relative'>
            <div
              class='decklist-description
                {{if (notEq @controller.display "writeup") "truncated"}}'
            >
              <h2>{{@model.decklist.name}}</h2>
              <div>
                {{this.displayHtml @model.decklist.notes}}
              </div>
            </div>
            {{#if
              (and
                (notEq @controller.display 'writeup')
                (gt @model.decklist.notes.length 200)
              )
            }}
              <button
                type='button'
                class='position-absolute px-2'
                style='bottom:0;right:0'
                {{on 'click' @controller.displayWriteUp}}
              >
                Read more
              </button>
            {{/if}}
          </div>
        </div>

        {{! DESCRIPTION }}
        {{! <div class="row mt-4">
        <div class="decklist-description">
          <h1 class="font-size-24">Throw Another Deer on the Barbie!</h1>
          <div class="user-content">
            <p>
              I've never really published a deck before and I have no idea what I
              am doing with markdown but I actually think I have something here so
              here goes nothing... Over my long Netrunner career I don't think
              I've ever felt like I've made a deck that was truely good. This deck
              though... This might actually be good? Honestly I'm not sure but
              it's definitely cool. I haven't played a lot of games with this yet
              but it's been surprisingly versatile and has a lot of outs you
              wouldn't expect.
            </p>
            <h2>Origin Story:</h2>
            <p>
              I was screwing around trying to make Orca work and ended up
              including a Mind's Eye because that seems like a good thing to have
              in an Orca deck. My big dumb whale got trashed and I was in the this
              odd game state where I could use Padma to farm counters and try to
              still win on RnD even though I was locked out. I didn't end up
              winning that game but it gave me a golden idea. How could we
              capitalise on that game state? I started thinking about the old
              Geist and Hayley decks that used Gbahali and Kongamato to break ice
              and I realised that a lot of the tools in the current card pool lend
              themselves to that kind of shell. Then I decided to make my idea
              worse by putting it in a pet ID that only has 12 influence!
            </p>
          </div>
        </div>
      </div> }}

        {{! CARDS }}
        {{#if (eq @controller.display 'list')}}
          <CardList @printings={{@model.decklist.cards}}>
            <:quantity as |card|>
              {{get @model.decklist.cardSlots card.id}}
            </:quantity>
          </CardList>
        {{else if (eq @controller.display 'images')}}
          <DecklistImages
            @decklist={{@model.decklist}}
            @cardTypes={{@model.cardTypes}}
          />
        {{/if}}
      </div>

    </main>
  </template>
}
