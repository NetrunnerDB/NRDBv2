import { LinkTo } from '@ember/routing';
import FaIcon from '@fortawesome/ember-fontawesome/components/fa-icon';
import { sortBy } from '@nullvoxpopuli/ember-composable-helpers';
import { pageTitle } from 'ember-page-title';

import Navbar from 'netrunnerdb/components/navbar';
import Titlebar from 'netrunnerdb/components/titlebar';
import CardList from 'netrunnerdb/components/card/list';

<template>
  {{pageTitle @model.cardCycle.name}}

  <main class='pb-4'>

    <Navbar />

    <Titlebar
      @title='Cycle'
      @subtitle={{@model.cardCycle.name}}
      @icon={{@model.cardCycle.id}}
    >
      <div class='d-flex position-relative mt-4 flex-column'>
        {{#if @model.prevCycle}}
          <LinkTo
            @model={{@model.prevCycle.id}}
            class='button round position-absolute end-0'
            style='transform: translateY(10px)'
          >
            <FaIcon @icon='arrow-left-long' />
            {{@model.prevCycle.name}}
          </LinkTo>
        {{/if}}
        {{#if @model.nextCycle}}
          <LinkTo
            @model={{@model.nextCycle.id}}
            class='button round position-absolute end-0'
            style='transform: translateY(-100%)'
          >
            {{@model.nextCycle.name}}
            <FaIcon @icon='arrow-right-long' />
          </LinkTo>
        {{/if}}
      </div>
    </Titlebar>

    <div class='container'>
      <CardList @printings={{sortBy 'position' @model.cardCycle.printings}} />
    </div>

  </main>
</template>
