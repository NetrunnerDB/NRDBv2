import { pageTitle } from 'ember-page-title';
import { formatMessage, formatDate } from 'ember-intl';
import { hash } from '@ember/helper';
import { LinkTo } from '@ember/routing';

import Titlebar from 'netrunnerdb/components/titlebar';
import Navbar from 'netrunnerdb/components/navbar';
import FancyHeader from 'netrunnerdb/components/fancy-header';

const FormatSection = <template>
  <div class='col-12'>
    <FancyHeader>{{@format.name}}</FancyHeader>
    <img
      alt={{@format.name}}
      src='/assets/image/format/{{@format.name}}.png'
      class='float-{{@float}} me-4'
      style='width: 100px'
    />

    {{yield to='description'}}

    <h3>Current Ban List</h3>
    <p>
      <LinkTo
        @route='bans'
        @query={{hash format=@format.id search=@format.currentRestriction.name}}
      >
        {{formatMessage
          '{name} active as of {dateStart}'
          name=@format.currentRestriction.name
          dateStart=(formatDate
            @format.currentRestriction.dateStart
            day='numeric'
            month='long'
            year='numeric'
          )
        }}
      </LinkTo>
    </p>
  </div>
</template>;

<template>
  {{pageTitle 'Formats'}}

  <main class='pb-4'>

    <Navbar />
    <Titlebar @title='Formats' @subtitle={{@model.standard.format.name}} />

    <div class='container'>
      <div class='row'>
        <FormatSection @format={{@model.standard.format}} @float='start'>
          <:description>
            <p>
              The flagship format of Netrunner Organized Play, Standard is
              frequently changing to keep the meta exciting and engaging for
              players of all levels. Most official Organized Play events will
              follow the Standard format. If a format is not specified, assume
              Standard, but contact your Tournament Organizer for clarity.
            </p>
          </:description>
        </FormatSection>
      </div>
    </div>
  </main>
</template>
