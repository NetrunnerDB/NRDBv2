import { pageTitle } from 'ember-page-title';
import { LinkTo } from '@ember/routing';
import Navbar from 'netrunnerdb/components/navbar';
import Titlebar from 'netrunnerdb/components/titlebar';
import Icon from 'netrunnerdb/components/icon';
import { eq } from 'netrunnerdb/utils/template-operators';
import gt from 'ember-truth-helpers/helpers/gt';
import formatISO8601Date from 'netrunnerdb/helpers/format-iso8601-date';
import { includes } from '@nullvoxpopuli/ember-composable-helpers';

<template>
  {{pageTitle "Sets"}}

  <main class="pb-4">

    <Navbar />
    <Titlebar @title="Sets" @subtitle="All sets from Netrunner history" />

    <div class="container">
      <table class="results mt-5">
        <thead>
          <tr>
            <th>Name</th>
            <th>Cards</th>
            <th>Release Date</th>
            <th>Publisher</th>
            <th>Legality</th>
            <th></th>
            <th></th>
          </tr>
        </thead>
        <tbody>
          {{#each @model.cycles as |cycle|}}
            <tr>
              <td>
                <Icon @icon={{cycle.id}} />
                {{#if (eq cycle.cardSets.length 1)}}
                  {{! Cursed way to get the first index of a singleton array }}
                  {{#each cycle.cardSets as |set|}}
                    <LinkTo @route="set" @model={{set.id}}>
                      {{cycle.name}}
                    </LinkTo>
                  {{/each}}
                {{else}}
                  <LinkTo @route="cycle" @model={{cycle.id}}>
                    {{cycle.name}}
                  </LinkTo>
                {{/if}}
              </td>
              <td>{{cycle.cardCount}}</td>
              <td>{{formatISO8601Date cycle.dateRelease}}</td>
              <td>{{if
                  (eq cycle.releasedBy "null_signal_games")
                  "NSG"
                  "FFG"
                }}</td>
              <td>{{if
                  (includes cycle.id @model.standard.cardCycleIds)
                  "Standard"
                }}</td>
              <td>{{if
                  (includes cycle.id @model.startup.cardCycleIds)
                  "Startup"
                }}</td>
              <td>{{if
                  (includes cycle.id @model.eternal.cardCycleIds)
                  "Eternal"
                }}</td>
            </tr>
            {{#if (gt cycle.cardSets.length 1)}}
              {{#each cycle.cardSets as |set|}}
                <tr>
                  <td>
                    <span class="ps-2">
                      <Icon @icon="subroutine" />
                      <LinkTo
                        @route="set"
                        @model={{set.id}}
                      >{{set.name}}</LinkTo>
                    </span>
                  </td>
                  <td>{{set.size}}</td>
                  <td>{{formatISO8601Date set.dateRelease}}</td>
                  <td>{{if
                      (eq cycle.releasedBy "null_signal_games")
                      "NSG"
                      "FFG"
                    }}</td>
                  <td>{{if
                      (includes set.id @model.standard.cardSetIds)
                      "Standard"
                    }}</td>
                  <td>{{if
                      (includes set.id @model.startup.cardSetIds)
                      "Startup"
                    }}</td>
                  <td>{{if
                      (includes set.id @model.eternal.cardSetIds)
                      "Eternal"
                    }}</td>
                </tr>
              {{/each}}
            {{/if}}
          {{/each}}
        </tbody>
      </table>
    </div>

  </main>
</template>
