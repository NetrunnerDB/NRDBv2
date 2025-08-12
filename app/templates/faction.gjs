import { pageTitle } from 'ember-page-title';
import Navbar from 'netrunnerdb/components/navbar';
import Titlebar from 'netrunnerdb/components/titlebar';
import FancyHeader from 'netrunnerdb/components/fancy-header';
import CardLinkTo from 'netrunnerdb/components/card/link-to';
import breakLines from 'netrunnerdb/helpers/break-lines';
import DecklistBoxCompact from 'netrunnerdb/components/decklist-box-compact';
import { LinkTo } from '@ember/routing';

<template>
  {{pageTitle @model.faction.name}}

  <main class="pb-4">
    <Navbar />
    <Titlebar
      @title="Faction"
      @subtitle={{@model.faction.name}}
      @icon={{@model.faction.id}}
    />

    <div class="container">
      {{#if @model.faction.description}}
        <div
          class="box fst-italic visible-lg mt-4 mx-5 bg-img-{{@model.faction.idHyphenated}}"
        >
          {{breakLines @model.faction.description}}
        </div>
      {{/if}}

      {{#each @model.ids as |id|}}
        <div class="row pt-4 pb-4">
          <h2 class="font-size-20">
            <CardLinkTo @printing={{id.latestPrinting}} class="primary">
              <FancyHeader>{{id.title}}</FancyHeader>
            </CardLinkTo>
          </h2>
          <div class="col-12 col-md-2">
            <img
              alt={{id.title}}
              class="w-100 visible-md mb-2 game-card"
              src="{{id.latestPrinting.images.nrdb_classic.large}}"
            />
            <LinkTo @route="home" class="button blue d-block mb-2">
              Create deck</LinkTo>
            {{#if id.pronouns}}
              <div>
                Pronouns:
                {{id.pronouns}}
              </div>
            {{/if}}
          </div>
          <div class="col-12 col-md-10">
            {{#each id.decklists as |decklist|}}
              <DecklistBoxCompact @decklist={{decklist}} @identity={{id}} />
              <br />
            {{/each}}
          </div>
        </div>
      {{/each}}
    </div>
  </main>
</template>
