import { LinkTo } from '@ember/routing';
import { hash } from '@ember/helper';
import { eq } from '../../utils/template-operators';
import Accordion from '../ui/accordion';
import formatDate from '../../helpers/format-date';
import Side from './side';

<template>
  <div class='card flex-grow-1' id='nav-main-content'>
    <div class='card-header'>
      <ul class='nav nav-tabs nav-fill card-header-tabs'>
        {{#each @formats as |format|}}
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
                  <:title>
                    {{restriction.name}}
                  </:title>
                  <:subtitle>
                    {{restriction.obj.size}}
                    cards. Start Date:
                    {{formatDate restriction.obj.dateStart}}.
                  </:subtitle>
                  <:body>
                    <div class='row'>
                      <Side
                        @side='corp'
                        @formats={{@loadedFormats}}
                        @selectedFormat={{@selectedFormat}}
                        @restriction={{restriction}}
                      />

                      <Side
                        @side='runner'
                        @formats={{@loadedFormats}}
                        @selectedFormat={{@selectedFormat}}
                        @restriction={{restriction}}
                      />
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
