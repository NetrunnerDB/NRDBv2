import Component from '@glimmer/component';
import { on } from '@ember/modifier';

export default class PanelComponent extends Component {
  get isFiltered() {
    return this.args.isFiltered ?? false;
  }

  <template>
    <div class='panel panel-default' hidden={{this.isFiltered}}>
      <div class='panel-heading'>
        <div class='panel-heading-text'>
          <h4 class='panel-heading-text-title'>{{yield to='title'}}</h4>
          {{#if (has-block 'subtitle')}}
            <h6 class='panel-heading-text-subtitle'>
              {{yield to='subtitle'}}
            </h6>
          {{/if}}
        </div>
        <button
          class='btn btn-secondary'
          type='button'
          {{on 'click' @togglePanel}}
        >{{if @isOpen 'Hide' 'Show'}}</button>
      </div>
      {{#if @isOpen}}
        <div class='panel-body'>
          {{yield to='body'}}
        </div>
      {{/if}}
    </div>
  </template>
}
