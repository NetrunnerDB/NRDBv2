import Component from '@glimmer/component';
import Icon from './icon';

class Titlebar extends Component {
  <template>
    <div class='titlebar'>
      <div class='container'>
        <div class='row'>
          <div class='col-5'>
            <div class='title font-size-16'>{{@title}}</div>
            <div class='subtitle font-size-28 fw-600'>
              {{@subtitle}}
              {{#if @icon}}<Icon @icon={{@icon}} />{{/if}}
            </div>
          </div>
          <div class='col-7'>
            {{yield}}
          </div>
        </div>
      </div>
    </div>
  </template>
}

export default Titlebar;
