import Component from '@glimmer/component';

export default class StringTextElementComponent extends Component {
  // Make lint be quiet about a glimmer component wrapping a template.
  get foo() {
    return 'foo';
  }

  <template>
    <div class='form-group'>
      <label for='{{@id}}'>{{@name}}:</label>
      <div>
        <input type='text' id='{{@id}}' name='{{@id}}' value='{{@value}}' />
      </div>
    </div>
  </template>
}
