import { pageTitle } from 'ember-page-title';
import Navbar from 'netrunnerdb/components/navbar';
import Titlebar from 'netrunnerdb/components/titlebar';
import FancyHeader from 'netrunnerdb/components/fancy-header';

<template>
  {{pageTitle 'Formats'}}

  <main class='pb-4'>
    <Navbar />
    <Titlebar @title='Rulings' />

    <div class='container'>
      <div class='row'>
        <div class='col-12'>
          <FancyHeader>All cards with clarification and F.A.Q.</FancyHeader>

          {{#each @model.rulings as |ruling|}}
            <div class='card mb-3'>
              <div class='card-body'>
                <h5 class='card-title'>
                  {{ruling.card.title}}
                  ({{ruling.card.latestPrinting.cardSet.name}},
                  {{ruling.card.latestPrinting.position}})
                  {{#if ruling.verified}}™{{/if}}
                </h5>

                <p>
                  {{{ruling.question}}}
                </p>
                <hr />
                <p>
                  {{ruling.answer}}
                </p>
              </div>
            </div>
          {{/each}}
        </div>
      </div>
    </div>
  </main>
</template>
