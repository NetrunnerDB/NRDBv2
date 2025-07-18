import { pageTitle } from 'ember-page-title';
import { t } from 'ember-intl';
import { LinkTo } from '@ember/routing';

import Navbar from 'netrunnerdb/components/navbar';
import Icon from 'netrunnerdb/components/icon';
import DecklistBox from 'netrunnerdb/components/decklist-box';
import BoxLink from 'netrunnerdb/components/box-link';
import DecklistBoxLink from 'netrunnerdb/components/decklist-box-link';

<template>
  {{pageTitle (t 'routes.home')}}

  <main class='pb-4'>
    <Navbar />

    <div class='container'>
      {{! Factions }}
      <div class='row mt-3 gy-2 hidden-sm'>
        <div class='col-lg col-3 order-lg-1'>
          <LinkTo
            @route='faction'
            @model='haas_bioroid'
            class='button d-block round'
          ><Icon @icon='haas-bioroid' />Haas-Bioroid</LinkTo>
        </div>
        <div class='col-lg col-3 order-lg-1'>
          <LinkTo
            @route='faction'
            @model='jinteki'
            class='button d-block round'
          ><Icon @icon='jinteki' />Jinteki</LinkTo>
        </div>
        <div class='col-lg col-3 order-lg-1'>
          <LinkTo
            @route='faction'
            @model='nbn'
            class='button d-block round'
          ><Icon @icon='nbn' />NBN</LinkTo>
        </div>
        <div class='col-lg col-3 order-lg-1'>
          <LinkTo
            @route='faction'
            @model='weyland_consortium'
            class='button d-block round'
          ><Icon @icon='weyland-consortium' />Weyland</LinkTo>
        </div>
        <div class='col-lg col-3 offset-lg-0 offset-1'>
          <LinkTo
            @route='faction'
            @model='anarch'
            class='button d-block round'
          ><Icon @icon='anarch' />Anarch</LinkTo>
        </div>
        <div class='col-lg col-3'>
          <LinkTo
            @route='faction'
            @model='criminal'
            class='button d-block round'
          ><Icon @icon='criminal' />Criminal</LinkTo>
        </div>
        <div class='col-lg col-3'>
          <LinkTo
            @route='faction'
            @model='shaper'
            class='button d-block round'
          ><Icon @icon='shaper' />Shaper</LinkTo>
        </div>
        <div class='col-lg col-2 order-lg-2'>
          {{! template-lint-disable no-invalid-link-text }}
          <LinkTo @route='factions' class='button d-block round'>More</LinkTo>
        </div>
      </div>

      <div class='row mt-4'>
        <div class='col-12 col-lg-8 col-xl-9'>
          <div class='box'>

            <h2>Decklist of the week</h2>

            {{#if @model.dotw}}
              <DecklistBox
                @decklist={{@model.dotw}}
                @showTitle='true'
                @showLink='true'
                @showAuthor='true'
              />

              <p class='my-4'>
                {{@model.dotwDesc}}
              </p>
              {{! template-lint-disable no-invalid-link-text }}
              <LinkTo
                @route='decklist'
                @model={{@model.dotw.id}}
                class='button'
              >
                Read more
              </LinkTo>
            {{else}}
              <p class='my-4'>
                There is no decklist of the week!
              </p>
            {{/if}}
          </div>
          <div class='box mt-4'>Something Else</div>
        </div>
        <div class='col-12 col-lg-4 col-xl-3 mt-4 mt-lg-0'>
          <BoxLink />

          <div class='mt-4'>
            <h3 class='mb-2 font-size-18'>Latest decks</h3>
            {{#each @model.latestDecklists as |decklist|}}
              <DecklistBoxLink @decklist={{decklist}} />
            {{/each}}
          </div>
          <div class='box mt-4'>List of upcoming tournaments</div>
        </div>
      </div>
    </div>

  </main>
</template>
