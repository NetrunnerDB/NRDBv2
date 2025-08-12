import { pageTitle } from 'ember-page-title';
import Navbar from 'netrunnerdb/components/navbar';
import Titlebar from 'netrunnerdb/components/titlebar';
import Review from 'netrunnerdb/components/review';

<template>
  {{pageTitle "Formats"}}

  <main class="pb-4">
    <Navbar />
    <Titlebar @subtitle="Reviews" />

    <div class="container">
      {{#each @model.reviews as |review|}}
        <Review
          @review={{review}}
          @showCard={{true}}
          @showPrinting={{true}}
          @card={{review.card}}
          @printing={{review.card.latestPrinting}}
        />
      {{/each}}

      <ul>
        {{#each @model.reviews as |review|}}
          <li>
            <h3>
              {{review.username}}
            </h3>

            <p>{{review.body}}</p>
          </li>
        {{/each}}

      </ul>
    </div>
  </main>
</template>
