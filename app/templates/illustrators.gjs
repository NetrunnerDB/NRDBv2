import { pageTitle } from 'ember-page-title';
import Navbar from 'netrunnerdb/components/navbar';
import Titlebar from 'netrunnerdb/components/titlebar';
import FancyHeader from 'netrunnerdb/components/fancy-header';
import Accordion from 'netrunnerdb/components/ui/accordion';
import { sortBy } from '@nullvoxpopuli/ember-composable-helpers';
import CardLinkTo from 'netrunnerdb/components/card/link-to';
import notEq from 'ember-truth-helpers/helpers/not-eq';
import CardImage from 'netrunnerdb/components/card/image';
import { Await } from '@warp-drive/ember';

<template>
  {{pageTitle "Illlustrators"}}

  <main class="pb-4">
    <Navbar />
    <Titlebar @title="Illlustrators" />

    <div class="container">
      <div class="row">
        <div class="col-12">
          <FancyHeader>Illustrators</FancyHeader>
          <p>
            The world of Netrunner has been brought to life by a wide selection
            of amazing artists!
          </p>
          <p>
            This page lists all artists whose work has appeared on cards and
            which cards they illustrated.
          </p>
        </div>

      </div>

      <div class="row">
        <div class="row">
          <Accordion
            @showSearch="true"
            @showSort="true"
            @items={{@model.illustrators}}
            @query={{this.search}}
            as |Panel illustrator|
          >
            <Panel>
              <:title>{{illustrator.name}}</:title>
              <:subtitle>
                {{illustrator.numPrintings}}
                card{{if (notEq illustrator.numPrintings 1) "s"}}
              </:subtitle>
              <:body>
                <div class="row">
                  <Await @promise={{illustrator.printings}}>
                    <:pending>
                      Loading cards...
                    </:pending>
                    <:success as |printings|>
                      {{#each (sortBy "title" printings) as |printing|}}
                        <div class="col-3 p-2">
                          <CardLinkTo
                            @printing={{printing}}
                            @hideTooltip="true"
                          >
                            <CardImage @printing={{printing}} @size="large" />
                          </CardLinkTo>
                        </div>
                      {{/each}}
                    </:success>
                  </Await>

                </div>
              </:body>
            </Panel>
          </Accordion>
        </div>
      </div>
    </div>
  </main>
</template>
