import { pageTitle } from 'ember-page-title';
import { LinkTo } from '@ember/routing';
import Navbar from 'netrunnerdb/components/navbar';
import Titlebar from 'netrunnerdb/components/titlebar';
import FaIcon from '@fortawesome/ember-fontawesome/components/fa-icon';
import { sortBy } from '@nullvoxpopuli/ember-composable-helpers';
import CardList from 'netrunnerdb/components/card/list';
import { Await } from '@warp-drive/ember';

<template>
  {{pageTitle @model.cardSet.name}}

  <main class='pb-4'>

    <Navbar />

    <Titlebar
      @title='Set'
      @subtitle={{@model.cardSet.name}}
      @icon={{@model.cardSet.cardCycleId}}
    >
      {{#if @model.prevSet}}
        <LinkTo
          @model={{@model.prevSet.id}}
          class='button round position-absolute end-0'
          style='top: 0; transform: translateY(-40%)'
        >
          <FaIcon @icon='arrow-left-long' />
          {{@model.prevSet.name}}
        </LinkTo>
      {{/if}}
      {{#if @model.nextSet}}
        <LinkTo
          @model={{@model.nextSet.id}}
          class='button round position-absolute end-0'
          style='bottom: 0; transform: translateY(40%)'
        >
          {{@model.nextSet.name}}
          <FaIcon @icon='arrow-right-long' />
        </LinkTo>
      {{/if}}
    </Titlebar>

    <div class='container'>
      <Await @promise={{@model.cardSet.printings}}>
        <:pending>
          Loading cards...
        </:pending>
        <:success as |printings|>
          <CardList @printings={{sortBy 'position' printings}} />
        </:success>
      </Await>
    </div>

  </main>
</template>
