import { pageTitle } from 'ember-page-title';
import Navbar from 'netrunnerdb/components/navbar';
import Titlebar from 'netrunnerdb/components/titlebar';
import FancyHeader from 'netrunnerdb/components/fancy-header';

<template>
  {{pageTitle 'Formats'}}

  <main class='pb-4'>
    <Navbar />
    <Titlebar @title='Bans' />

    <div class='container'>
      <div class='row'>
        <div class='col-12'>
          <FancyHeader>Standard</FancyHeader>
          <p>
            The flagship format of Netrunner Organized Play, Standard is
            frequently changing to keep the meta exciting and engaging for
            players of all levels. Most official Organized Play events will
            follow the Standard format. If a format is not specified, assume
            Standard, but contact your Tournament Organizer for clarity.</p>
        </div>
      </div>
    </div>
  </main>
</template>
