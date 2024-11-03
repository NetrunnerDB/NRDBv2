import Component from '@glimmer/component';
import { htmlSafe } from '@ember/template';
import Icon from 'netrunnerdb/components/icon';

export default class CardTextComponent extends Component {
  constructor(...args) {
    super(...args);

    let text = this.args?.text || '';
    let processed = text
      .replaceAll('[trash]', '[trash-ability]')
      .replaceAll('\n', '<br>');
    let iconRegex = /\[[^\d]*?\]/g;
    let matches = processed.match(iconRegex);
    if (matches) {
      // There is at least one symbol in the card text
      let icons = matches.map((s) =>
        htmlSafe(s.substring(1, s.length - 1)).toString(),
      );
      let strings = processed.split(iconRegex).map((s) => htmlSafe(s));
      // strings.length >= icons.length
      this.segments = strings.map((s, i) => ({
        string: s,
        icon: icons[i],
      }));
    } else {
      // There are no symbols in the card text
      this.segments = [
        {
          string: htmlSafe(processed),
          icon: null,
        },
      ];
    }
  }

  <template>
    <p>
      {{#each this.segments as |segment|}}
        {{segment.string}}
        {{#if segment.icon}}
          <Icon @icon={{segment.icon}} />
        {{/if}}
      {{/each}}
    </p>
  </template>
}
