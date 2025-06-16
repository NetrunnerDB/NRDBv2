import { pageTitle } from 'ember-page-title';
import { t } from 'ember-intl';

<template>
  {{pageTitle (t 'app_title')}}

  {{outlet}}
</template>
