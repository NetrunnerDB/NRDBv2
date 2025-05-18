import { pageTitle } from 'ember-page-title';
import FaIcon from '@fortawesome/ember-fontawesome/components/fa-icon';

import Navbar from 'netrunnerdb/components/navbar';
import Titlebar from 'netrunnerdb/components/titlebar';
import CardLinkTo from 'netrunnerdb/components/card/link-to';
import CardFullDisplay from 'netrunnerdb/components/card/full-display';
import Ruling from 'netrunnerdb/components/ruling';
import Review from 'netrunnerdb/components/review';
import BsTab from 'ember-bootstrap/components/bs-tab';

<template>
  {{pageTitle @model.cardSet.name}}

  <main class='pb-4'>

    <Navbar />

    <Titlebar
      @title='Card'
      @subtitle={{@model.card.title}}
      @icon={{@model.cardSet.cardCycleId}}
    >
      {{#if @model.prevPrinting}}
        <CardLinkTo
          @id={{@model.prevPrinting.id}}
          class='button round position-absolute end-0'
          style='top: 0; transform: translateY(-40%)'
        >
          <FaIcon @icon='arrow-left-long' />
          {{@model.prevPrinting.title}}
        </CardLinkTo>
      {{/if}}
      {{#if @model.nextPrinting}}
        <CardLinkTo
          @id={{@model.nextPrinting.id}}
          class='button round position-absolute end-0'
          style='bottom: 0; transform: translateY(40%)'
        >
          {{@model.nextPrinting.title}}
          <FaIcon @icon='arrow-right-long' />
        </CardLinkTo>
      {{/if}}
    </Titlebar>

    <div class='container'>
      <div class='mt-4'>
        <CardFullDisplay
          @card={{@model.card}}
          @printing={{@model.printing}}
          @allPrintings={{@model.allPrintings}}
          @eternalSnapshot={{@model.eternalSnapshot}}
          @standardSnapshot={{@model.standardSnapshot}}
          @startupSnapshot={{@model.startupSnapshot}}
        />
      </div>

      <div class='mt-4'>
        <BsTab @type='pills' as |tab|>
          <tab.pane @title='Reviews'>
            {{#each @model.reviews as |review|}}
              <div class='mt-4'>
                <div class='mb-5'>
                  <Review @card={{@model.card}} @review={{review}} />
                </div>
              </div>
            {{else}}
              <div class='ruling-answer mt-4'>
                This card has no reviews!
              </div>
            {{/each}}
          </tab.pane>
          <tab.pane @title='Rulings '>
            {{#each @model.rulings as |ruling|}}
              <div class='mt-4'>
                <Ruling @ruling={{ruling}} />
              </div>
            {{else}}
              <div class='ruling-answer mt-4'>
                This card has no rulings!
              </div>
            {{/each}}
          </tab.pane>
          <tab.pane @title='Alt arts'>
            <p> ... </p>
          </tab.pane>
        </BsTab>
      </div>

    </div>
  </main>
</template>
