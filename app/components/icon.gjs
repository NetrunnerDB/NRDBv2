import Component from '@glimmer/component';
import { format } from './quote';
import { svgJar } from 'ember-svg-jar/helpers/svg-jar';

<template>
  {{svgJar
    @icon
    height='1em'
    style='max-width: 100%; transform: translateY(-2px)'
  }}
</template>
