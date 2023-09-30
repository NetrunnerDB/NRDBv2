import { LinkTo } from '@ember/routing';
import { hash } from '@ember/helper';
import { eq } from '../../utils/template-operators';
import Accordion from '../ui/accordion';
import CardLinkTo from '../card/link-to';
import formatDate from '../../helpers/format-date';

<template>
  <div class="card flex-grow-1" id="nav-main-content">
    <div class="card-header">
      <ul class="nav nav-tabs nav-fill card-header-tabs">
        {{#each @formats as |format|}}
          <li class="nav-item">
            <LinkTo
              class="nav-link"
              @route="page.banlists"
              @query={{hash format=format.id}}
            >{{format.name}}</LinkTo>
          </li>
        {{/each}}
      </ul>
    </div>
    <div class="card-body">
      {{#each @formats as |format|}}
        {{#if (eq @selectedFormat format.id)}}
          <div id={{format.id}}>
            <Accordion
              @showMassToggle={{true}}
              @showSearch={{true}}
              @query={{@query}}
              @expandFirstItem={{true}}
              @items={{format.restrictions}}
            >
              <:default as |Panel item|>
                <Panel>
                  <:title>
                    {{item.name}}
                  </:title>
                  <:subtitle>
                    {{item.size}}
                    cards. Start Date:
                    {{(formatDate item.dateStart)}}.
                  </:subtitle>
                  <:body>
                    <div class="row">
                      <div class="col-6">
                        <h3>Corp Cards</h3>
                        <ul>
                          <li>
                            <strong>Banned</strong>
                            <ul>
                              {{#each item.verdicts.banned as |banned|}}
                                <li>
                                  <CardLinkTo
                                    @id={{banned}}
                                    class="text-truncate"
                                  >
                                    {{banned}}
                                  </CardLinkTo>
                                </li>
                              {{/each}}
                            </ul>
                          </li>
                        </ul>
                      </div>
                      <div class="col-6">
                        <h3>Runner Cards</h3>
                      </div>
                    </div>
                  </:body>
                </Panel>
              </:default>
              <:empty>
                No cards are currently banned in
                {{format.name}}. Have a blast!
              </:empty>
            </Accordion>
          </div>
        {{/if}}
      {{/each}}
    </div>
  </div>
</template>
