import { LinkTo } from '@ember/routing';
import { fn, hash } from '@ember/helper';

import LinkToCard from '../card/link-to';
import PanelList from '../panel-list';
import Panel from '../panel';
import formatDate from '../../helpers/format-date';
import { eq } from '../../utils/template-operators';

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
            {{#if format.restrictions}}
              <PanelList
                @showMassToggle="true"
                @showSearch="true"
                @items={{format.restrictions}}
                as |restriction isOpen actions|
              >
                <Panel
                  @title="{{restriction.name}}"
                  @subtitle="{{restriction.size}} cards. Start Date: {{formatDate restriction.dateStart}}."
                  @isOpen={{isOpen}}
                  @showPanel={{fn actions.showPanel restriction.name}}
                  @hidePanel={{fn actions.hidePanel restriction.name}}
                >
                  <div class="row">
                    <div class="col-6">
                      <h3>Corp Cards</h3>
                      <ul>
                        <li>
                          <strong>Banned</strong>
                          <ul>
                            {{#each restriction.verdicts.banned as |banned|}}
                              <li>
                                <LinkToCard
                                  @id={{banned}}
                                  class="text-truncate"
                                >
                                  {{banned}}
                                </LinkToCard>
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
                </Panel>
              </PanelList>
            {{else}}
              No cards are currently banned in
              {{format.name}}. Have a blast!
            {{/if}}
          </div>
        {{/if}}
      {{/each}}
    </div>
  </div>
</template>
