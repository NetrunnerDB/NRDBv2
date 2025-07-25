import Component from '@glimmer/component';
import CardRuling from './ruling';
import { tracked } from '@glimmer/tracking';
import { action } from '@ember/object';
import { fn } from '@ember/helper';
import { on } from '@ember/modifier';
import { eq } from 'netrunnerdb/utils/template-operators';
import { sortBy } from '@nullvoxpopuli/ember-composable-helpers';

export default class CardCommunityComponent extends Component {
  @tracked tab = 'content-rulings';

  @action setTab(tabId) {
    this.tab = tabId;
  }

  <template>
    <div class='card flex-grow-1' id='nav-main-content'>
      <div class='card-header'>
        <ul class='nav nav-tabs nav-fill card-header-tabs'>
          <li class='nav-item'>
            <a
              href='#'
              role='button'
              class='nav-link {{if (eq this.tab "content-rulings") "active"}}'
              {{on 'click' (fn this.setTab 'content-rulings')}}
            >Rulings</a>
          </li>
          <li class='nav-item'>
            <a
              href='#'
              role='button'
              class='nav-link {{if (eq this.tab "content-reviews") "active"}}'
              {{on 'click' (fn this.setTab 'content-reviews')}}
            >Reviews</a>
          </li>
          <li class='nav-item'>
            <a
              href='#'
              role='button'
              class='nav-link {{if (eq this.tab "content-forum") "active"}}'
              {{on 'click' (fn this.setTab 'content-forum')}}
            >Forum</a>
          </li>
        </ul>
      </div>

      <div class='card-body'>
        {{#if (eq this.tab 'content-rulings')}}
          <div id='content-rulings'>
            {{! TODO(plural): Put ruling display into a new component with pretty formatting. }}
            {{#each (sortBy 'updatedAt:desc' @rulings) as |ruling|}}
              <CardRuling @ruling={{ruling}} />
            {{/each}}
          </div>
        {{else if (eq this.tab 'content-reviews')}}
          <div id='content-reviews'>
            Reviews go here
          </div>
        {{else if (eq this.tab 'content-forum')}}
          <div id='content-forum'>
            Against all odds, here be a forum
          </div>
        {{/if}}
      </div>
    </div>
  </template>
}
