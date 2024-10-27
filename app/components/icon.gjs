import { svgJar } from 'ember-svg-jar/helpers/svg-jar';
import { Hyphenate } from '../helpers/hyphenate';

<template>
  {{svgJar
    (Hyphenate @icon)
    height='1em'
    style='max-width: 100%; transform: translateY(-2px)'
  }}
</template>
