import { pageTitle } from 'ember-page-title';
import Navbar from 'netrunnerdb/components/navbar';
import Titlebar from 'netrunnerdb/components/titlebar';

<template>
  {{pageTitle 'Formats'}}

  <main class='pb-4'>
    <Navbar />
    <Titlebar @subtitle='Reviews' />

    <div class='container'>
      TODO: Add latest reviews with page navigation here.
    </div>
  </main>
</template>
