import { pageTitle } from 'ember-page-title';
import Navbar from 'netrunnerdb/components/navbar';
import Titlebar from 'netrunnerdb/components/titlebar';
import FancyHeader from 'netrunnerdb/components/fancy-header';
import Ruling from 'netrunnerdb/components/ruling';
import Icon from 'netrunnerdb/components/icon';
import CardLinkTo from 'netrunnerdb/components/card/link-to';
import { sortBy } from '@nullvoxpopuli/ember-composable-helpers';

<template>
  {{pageTitle 'Rulings'}}

  <main class='pb-4'>
    <Navbar />
    <Titlebar @title='Rulings' />

    <div class='container'>
      <div class='row'>
        <div class='col-12'>
          <FancyHeader>All cards with clarification and F.A.Q.</FancyHeader>

          {{#each (sortBy 'updatedAt:desc' @model.rulings) as |ruling|}}
            <div class='card mb-3'>
              <div class='card-body'>
                <h5 class='card-title'>
                  <CardLinkTo @printing={{ruling.card.latestPrinting}}>
                    {{ruling.card.title}}
                  </CardLinkTo>
                  (<Icon @icon={{ruling.card.latestPrinting.cardCycle.id}} />
                  {{ruling.card.latestPrinting.cardSet.name}},
                  {{ruling.card.latestPrinting.position}})
                </h5>

                <Ruling @ruling={{ruling}} />
              </div>
            </div>
          {{/each}}
        </div>
      </div>
    </div>
  </main>
</template>
