import { pageTitle } from 'ember-page-title';
import Navbar from 'netrunnerdb/components/navbar';
import CardList from 'netrunnerdb/components/card/list';

<template>
  {{pageTitle "Search"}}

  <main class="pb-4">
    <Navbar />

    <div class="container">
      {{! BUTTON - Refine search }}
      {{! DISPLAY - Showing X Results }}
    </div>

    <div class="container">
      {{#if @model.printings.length}}
        <CardList @printings={{@model.printings}} />
      {{/if}}
    </div>
  </main>
</template>
