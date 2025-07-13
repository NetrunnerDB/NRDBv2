import { pageTitle } from 'ember-page-title';
import { LinkTo } from '@ember/routing';
import { hash } from '@ember/helper';
import { eq } from 'netrunnerdb/utils/template-operators';
import Accordion from 'netrunnerdb/components/ui/accordion';
import formatDate from 'netrunnerdb/helpers/format-date';
import Side from 'netrunnerdb/components/banlist/side';
import { formatMessage } from 'ember-intl';
import Navbar from 'netrunnerdb/components/navbar';
import Titlebar from 'netrunnerdb/components/titlebar';

<template>
  {{pageTitle 'Ban Lists'}}

  <main class='pb-4'>
    <Navbar />
    <Titlebar @title='Ban Lists' />

    <div class='container'>
      <div class='row'>
        <div class='col-12'>
          <div class='card border-0 flex-grow-1' id='nav-main-content'>
            <div
              class='card-body d-flex flex-column flex-lg-row justify-content-between'
            >
              <div>
                <p>There are currently three official
                  <a href='/en/formats'>formats</a>
                  supported by Null Signal Games: Startup, Standard, and
                  Eternal. This page displays the ban lists for each.</p>
                <h2>Explanation</h2>
                <ul>
                  <li><b>Banned:</b>
                    You cannot include any copies of a banned card in your deck.</li>
                  <li><b>Points:</b>
                    Including any number of copies of a card with points in
                    Eternal adds points to your deck. Eternal decks must have 7
                    points or fewer.</li>
                  <li><b>Restricted (deprecated):</b>
                    You may include up to a full playset of only one restricted
                    card.</li>
                  <li><b>Universal Influence (deprecated):</b>
                    Cards with universal influence cost additional influence to
                    include in a deck.</li>
                  <li><b>Identity Influence Reduction (deprecated):</b>
                    These cards reduce your identity's influence limit by 1 for
                    each copy (to a minimum of 1).</li>
                </ul>
                <p>See
                  <a
                    href='https://nullsignal.games/players/supported-formats/'
                  >Null Signal Games' Supported Formats page</a>
                  for more information.</p>

                <div class='card flex-grow-1' id='nav-main-content'>
                  <div class='card-header'>
                    <ul class='nav nav-tabs nav-fill card-header-tabs'>
                      {{#each @model.formats as |format|}}
                        <li class='nav-item'>
                          <LinkTo
                            class='nav-link'
                            @route='bans'
                            @query={{hash format=format.id}}
                          >{{format.name}}</LinkTo>
                        </li>
                      {{/each}}
                    </ul>
                  </div>
                  <div class='card-body'>
                    {{#each @model.formats as |format|}}
                      {{#if (eq @controller.format format.id)}}
                        <div id={{format.id}}>
                          <Accordion
                            @showMassToggle={{true}}
                            @showSearch={{true}}
                            @query={{@controller.search}}
                            @expandFirstItem={{true}}
                            @items={{format.restrictions}}
                          >
                            <:default as |Panel restriction|>
                              <Panel>
                                <:title>
                                  {{restriction.name}}
                                </:title>
                                <:subtitle>
                                  {{formatMessage
                                    '{count, plural, one {# card} other {# cards}}. Start Date: {date}.'
                                    count=restriction.obj.size
                                    date=(formatDate restriction.obj.dateStart)
                                  }}
                                </:subtitle>
                                <:body>
                                  <div class='row'>
                                    <Side
                                      @side='corp'
                                      @formats={{@model.loadedFormats}}
                                      @selectedFormat={{@controller.format}}
                                      @restriction={{restriction}}
                                      @cards={{@model.cards}}
                                    />

                                    <Side
                                      @side='runner'
                                      @formats={{@model.loadedFormats}}
                                      @selectedFormat={{@controller.format}}
                                      @restriction={{restriction}}
                                      @cards={{@model.cards}}
                                    />
                                  </div>
                                </:body>
                              </Panel>
                            </:default>
                            <:empty>
                              {{formatMessage
                                'No cards are currently banned in {format}. Have a blast!'
                                format=format.name
                              }}
                            </:empty>
                          </Accordion>
                        </div>
                      {{/if}}
                    {{/each}}
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  </main>
</template>
