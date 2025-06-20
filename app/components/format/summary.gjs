import { sortBy } from '@nullvoxpopuli/ember-composable-helpers';
import { hash } from '@ember/helper';
import { LinkTo } from '@ember/routing';

import Icon from '../icon';
import { eq, formatDate } from '../../utils/template-operators';

<template>
  <div class='col'>
    <h2>{{@model.format.name}} Format</h2>
    <h3>Current banlist</h3>
    <ul class='list-unstyled ms-4'>
      {{#if @model.format.activeRestrictionId}}
        <li><LinkTo
            @route='page.banlists'
            @query={{hash
              format=@model.format.id
              search=@model.snapshot.restriction.name
            }}
          >{{@model.snapshot.restriction.name}}</LinkTo></li>
        <li>
          active as of
          <strong>{{formatDate @model.snapshot.restriction.dateStart}}</strong>
        </li>
      {{else}}
        <li><strong>No banlist</strong></li>
      {{/if}}
    </ul>
    <h3>Corp decklists</h3>
    <ul class='list-unstyled ms-4'>
      <li><a href='#'>Any Corp</a></li>
      <li><Icon @icon='haas-bioroid' />
        <a href='#'>Haas-Bioroid</a></li>
      <li><Icon @icon='jinteki' />
        <a href='#'>Jinteki</a></li>
      <li><Icon @icon='nbn' /> <a href='#'>NBN</a></li>
      <li><Icon @icon='weyland-consortium' />
        <a href='#'>Weyland Consortium</a></li>
    </ul>
    <h3>Runner decklists</h3>
    <ul class='list-unstyled ms-4'>
      <li><a href='#'>Any Runner</a></li>
      <li><Icon @icon='anarch' />
        <a href='#'>Anarch</a></li>
      <li><Icon @icon='criminal' />
        <a href='#'>Criminal</a></li>
      <li><Icon @icon='shaper' />
        <a href='#'>Shaper</a></li>
      {{! TODO: automate this properly }}
      {{#unless (eq @model.format.id 'startup')}}
        <li><Icon @icon='adam' />
          <a href='#'>Adam</a></li>
        <li><Icon @icon='apex' />
          <a href='#'>Apex</a></li>
        <li><Icon @icon='sunny-lebeau' />
          <a href='#'>Sunny Lebeau</a></li>
      {{/unless}}
    </ul>
    <h3>Legal cardpool</h3>
    <p>{{@model.snapshot.cardPool.numCards}} unique cards</p>
    <ul>
      {{! TODO: denote cycles which are only partially legal (Terminal Directive) }}
      {{#each
        (sortBy 'dateRelease:desc' @model.snapshot.cardPool.cardCycles)
        as |cycle|
      }}
        <li>
          <LinkTo
            @route='page.cycle'
            @model='{{cycle.id}}'
          >{{cycle.name}}</LinkTo>
        </li>
      {{/each}}
    </ul>
  </div>
</template>
