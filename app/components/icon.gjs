import Component from '@glimmer/component';
import { svgJar } from 'ember-svg-jar/helpers/svg-jar';
import { Hyphenate } from '../helpers/hyphenate';

export default class Icon extends Component {
  <template>
    {{svgJar
      (Hyphenate @icon)
      height='1em'
      style='max-width: 100%; transform: translateY(-2px)'
    }}
  </template>
}
