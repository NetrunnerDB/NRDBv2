import Component from '@glimmer/component';
import selectOption from '../../modifiers/select-option';

export default class SelectElementComponent extends Component {
  // Make lint be quiet about a glimmer component wrapping a template.
  get foo() {
    return 'foo';
  }

  // Treat the options conventionally like model entities, with an id and a name value.
  <template>
    <label for="{{@id}}">{{@name}}</label>
    <select id="{{@id}}" name="{{@id}}" {{selectOption @value}}>
      {{#if @emptyDefault}}
        <option value="">{{@emptyDefault}}</option>
      {{/if}}
      {{#each @options as |o|}}
        <option value="{{o.id}}">{{o.name}}</option>
      {{/each}}
    </select>
  </template>
}
