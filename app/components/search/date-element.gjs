import Component from '@glimmer/component';

export default class DateElementComponent extends Component {
  // Make lint be quiet about a glimmer component wrapping a template.
  get foo() {
    return 'foo';
  }

  <template>
    <label for='{{@id}}'>{{@name}}:</label>
    <input type='date' id='{{@id}}' name='{{@id}}' value='{{@value}}' />
  </template>
}
