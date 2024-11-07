import Component from '@glimmer/component';
import { eq } from '../../utils/template-operators';

export default class CheckboxElementComponent extends Component {
  // Make lint be quiet about a glimmer component wrapping a template.
  get foo() {
    return 'foo';
  }

  <template>
    <label for='{{@id}}'>{{@name}}</label>
    <input
      id='{{@id}}'
      name='{{@id}}'
      type='checkbox'
      checked={{eq @value 'true'}}
      value='true'
    />
  </template>
}
