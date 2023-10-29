import Component from '@glimmer/component';

export default class NumericElementComponent extends Component {
  // Make lint be quiet about a glimmer component wrapping a template.
  get foo() {
    return 'foo';
  }

  <template>
    <label for='{{@id}}'>{{@name}}:</label>
    <input
      type='number'
      min='{{@min}}'
      max='{{@max}}'
      id='{{@id}}'
      name='{{@id}}'
      value='{{@value}}'
    />
  </template>
}
