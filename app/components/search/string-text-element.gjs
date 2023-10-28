import Component from '@glimmer/component';

export default class StringTextElementComponent extends Component {
  // Make lint be quiet about a glimmer component wrapping a template.
  get foo() {
    return 'foo';
  }

  <template>
    <label for='{{@id}}'>{{@name}}:</label>
    <input
      type='text'
      id='{{@id}}'
      name='{{@id}}'
      value='{{@value}}'
    />
  </template>
}
