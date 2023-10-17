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
              <:default as |Panel restriction|>
                <Panel>
                  {{! each restriction}}
                  <:title>
                    {{restriction.name}}
                  </:title>
                  <:subtitle>
                    {{restriction.obj.size}}
                    cards. Start Date:
                    {{(formatDate restriction.obj.dateStart)}}.
                  </:subtitle>
                  <:body>
                    <div class="row">
                      <div class="col-6">
                        <h3>Corp Cards</h3>
                        {{#if restriction.obj.verdicts.banned.length }}
                        <ul>
                          <li>
                            <strong>Banned</strong>
                            <ul>
                              {{#each restriction.corp.banned as |banned|}}
                                <li>
                                  <CardLinkTo
                                    @printing={{banned}}
                                    class="text-truncate"
                                  >
                                    {{banned.title}}
                                  </CardLinkTo>
                                </li>
                              {{/each}}
                            </ul>
                          </li>
                        </ul>
                        {{/if}}

                        {{#if restriction.obj.verdicts.restricted.length }}
                        <ul>
                          <li>
                            <strong>Restricted</strong>
                            <ul>
                              {{#each restriction.corp.restricted as |restricted|}}
                                <li>
                                  <CardLinkTo
                                    @printing={{restricted}}
                                    class="text-truncate"
                                  >
                                    {{restricted.title}}
                                  </CardLinkTo>
                                </li>
                              {{/each}}
                            </ul>
                          </li>
                        </ul>
                        {{/if}}

                        {{#if restriction.obj.verdicts.global_penalty.length }}
                        <ul>
                          <li>
                            <strong>Global Penalty</strong>
                            <ul>
                              {{#each restriction.corp.global_penalty as |global_penalty|}}
                                <li>
                                  <CardLinkTo
                                    @printing={{global_penalty}}
                                    class="text-truncate"
                                  >
                                    {{global_penalty.title}}
                                  </CardLinkTo>
                                </li>
                              {{/each}}
                            </ul>
                          </li>
                        </ul>
                        {{/if}}

                        {{#if restriction.hasPoints }}
                        <ul>
                          <li>
                            <strong>Points</strong>
                            <ul>
                              <li>
                                <strong>3 Points</strong>
                                <ul>
                                  {{#each restriction.corp.threePoints as |card|}}
                                    <li>
                                      <CardLinkTo
                                        @printing={{card}}
                                        class="text-truncate"
                                      >
                                        {{card.title}}
                                      </CardLinkTo>
                                    </li>
                                  {{/each}}
                                </ul>
                              </li>
                              <li>
                                <strong>2 Points</strong>
                                <ul>
                                  {{#each restriction.corp.twoPoints as |card|}}
                                    <li>
                                      <CardLinkTo
                                        @printing={{card}}
                                        class="text-truncate"
                                      >
                                        {{card.title}}
                                      </CardLinkTo>
                                    </li>
                                  {{/each}}
                                </ul>
                              </li>
                              <li>
                                <strong>1 Point</strong>
                                <ul>
                                  {{#each restriction.corp.onePoint as |card|}}
                                    <li>
                                      <CardLinkTo
                                        @printing={{card}}
                                        class="text-truncate"
                                      >
                                        {{card.title}}
                                      </CardLinkTo>
                                    </li>
                                  {{/each}}
                                </ul>
                              </li>
                            </ul>
                          </li>
                        </ul>
                        {{/if}}

                        {{#if restriction.hasUniversalInfluence }}
                        <ul>
                          <li>
                            <strong>Universal Influence</strong>
                            <ul>
                              {{#if restriction.corp.threeUniversalInfluence.length }}
                              <li>
                                <strong>3 Influence</strong>
                                <ul>
                                  {{#each restriction.corp.threeUniversalInfluence as |card|}}
                                    <li>
                                      <CardLinkTo
                                        @printing={{card}}
                                        class="text-truncate"
                                      >
                                        {{card.title}}
                                      </CardLinkTo>
                                    </li>
                                  {{/each}}
                                </ul>
                              </li>
                              {{/if}}
                              {{#if restriction.corp.oneUniversalInfluence.length }}
                              <li>
                                <strong>1 Universal Influence</strong>
                                <ul>
                                  {{#each restriction.corp.oneUniversalInfluence as |card|}}
                                    <li>
                                      <CardLinkTo
                                        @printing={{card}}
                                        class="text-truncate"
                                      >
                                        {{card.title}}
                                      </CardLinkTo>
                                    </li>
                                  {{/each}}
                                </ul>
                              </li>
                              {{/if}}
                            </ul>
                          </li>
                        </ul>
                        {{/if}}

                      </div>

                      <div class="col-6">
                        <h3>Runner Cards</h3>
                        {{#if restriction.obj.verdicts.banned.length }}
                        <ul>
                          <li>
                            <strong>Banned</strong>
                            <ul>
                              {{#each restriction.runner.banned as |banned|}}
                                <li>
                                  <CardLinkTo
                                    @printing={{banned}}
                                    class="text-truncate"
                                  >
                                    {{banned.title}}
                                  </CardLinkTo>
                                </li>
                              {{/each}}
                            </ul>
                          </li>
                        </ul>
                        {{/if}}

                        {{#if restriction.obj.verdicts.restricted.length }}
                        <ul>
                          <li>
                            <strong>Restricted</strong>
                            <ul>
                              {{#each restriction.runner.restricted as |restricted|}}
                                <li>
                                  <CardLinkTo
                                    @printing={{restricted}}
                                    class="text-truncate"
                                  >
                                    {{restricted.title}}
                                  </CardLinkTo>
                                </li>
                              {{/each}}
                            </ul>
                          </li>
                        </ul>
                        {{/if}}

                        {{#if restriction.obj.verdicts.global_penalty.length }}
                        <ul>
                          <li>
                            <strong>Global Penalty</strong>
                            <ul>
                              {{#each restriction.runner.global_penalty as |global_penalty|}}
                                <li>
                                  <CardLinkTo
                                    @printing={{global_penalty}}
                                    class="text-truncate"
                                  >
                                    {{global_penalty.title}}
                                  </CardLinkTo>
                                </li>
                              {{/each}}
                            </ul>
                          </li>
                        </ul>
                        {{/if}}

                        {{#if restriction.hasPoints }}
                        <ul>
                          <li>
                            <strong>Points</strong>
                            <ul>
                              <li>
                                <strong>3 Points</strong>
                                <ul>
                                  {{#each restriction.runner.threePoints as |card|}}
                                    <li>
                                      <CardLinkTo
                                        @printing={{card}}
                                        class="text-truncate"
                                      >
                                        {{card.title}}
                                      </CardLinkTo>
                                    </li>
                                  {{/each}}
                                </ul>
                              </li>
                              <li>
                                <strong>2 Points</strong>
                                <ul>
                                  {{#each restriction.runner.twoPoints as |card|}}
                                    <li>
                                      <CardLinkTo
                                        @printing={{card}}
                                        class="text-truncate"
                                      >
                                        {{card.title}}
                                      </CardLinkTo>
                                    </li>
                                  {{/each}}
                                </ul>
                              </li>
                              <li>
                                <strong>1 Point</strong>
                                <ul>
                                  {{#each restriction.runner.onePoint as |card|}}
                                    <li>
                                      <CardLinkTo
                                        @printing={{card}}
                                        class="text-truncate"
                                      >
                                        {{card.title}}
                                      </CardLinkTo>
                                    </li>
                                  {{/each}}
                                </ul>
                              </li>
                            </ul>
                          </li>
                        </ul>
                        {{/if}}

                        {{#if restriction.hasUniversalInfluence }}
                        <ul>
                          <li>
                            <strong>Universal Influence</strong>
                            <ul>
                              {{#if restriction.runner.threeUniversalInfluence.length }}
                              <li>
                                <strong>3 Influence</strong>
                                <ul>
                                  {{#each restriction.runner.threeUniversalInfluence as |card|}}
                                    <li>
                                      <CardLinkTo
                                        @printing={{card}}
                                        class="text-truncate"
                                      >
                                        {{card.title}}
                                      </CardLinkTo>
                                    </li>
                                  {{/each}}
                                </ul>
                              </li>
                              {{/if}}
                              {{#if restriction.runner.oneUniversalInfluence.length }}
                              <li>
                                <strong>1 Universal Influence</strong>
                                <ul>
                                  {{#each restriction.runner.oneUniversalInfluence as |card|}}
                                    <li>
                                      <CardLinkTo
                                        @printing={{card}}
                                        class="text-truncate"
                                      >
                                        {{card.title}}
                                      </CardLinkTo>
                                    </li>
                                  {{/each}}
                                </ul>
                              </li>
                              {{/if}}
                            </ul>
                          </li>
                        </ul>
                        {{/if}}

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
