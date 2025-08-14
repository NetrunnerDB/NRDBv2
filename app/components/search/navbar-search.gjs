import Component from '@glimmer/component';
import { tracked } from '@glimmer/tracking';
import { action } from '@ember/object';
import { service } from '@ember/service';
import { LinkTo } from '@ember/routing';
import { on } from '@ember/modifier';
import { and } from 'netrunnerdb/utils/template-operators';

export default class NavbarSearchComponent extends Component {
  @service('all-printings') allPrintings;

  @tracked isOpen = false;
  @tracked query = '';
  @tracked results = [];

  @action open() {
    this.isOpen = true;
  }

  @action onKeyDown(e) {
    if (e.key === 'Escape') {
      this.isOpen = false;
    }
  }

  @action handleBlur(e) {
    const next = e.relatedTarget;
    if (next && document.querySelector('.search-results')?.contains(next)) {
      e.preventDefault?.();
      return;
    }
    this.isOpen = false;
  }

  @action updateQuery(e) {
    this.query = e.target.value;
    let q = this.query?.trim();
    if (!q) {
      this.results = [];
      return;
    }
    this.results = this.allPrintings.search(q, 5);
  }

  <template>
    <form>
      <div class='search-container'>
        <input
          class='w-100'
          type='text'
          placeholder='Search'
          aria-label='Search'
          {{on 'focus' this.open}}
          {{on 'blur' this.handleBlur}}
          {{on 'keydown' this.onKeyDown}}
          {{on 'input' this.updateQuery}}
        />
        {{#if (and this.isOpen this.results.length)}}
          <div class='search-results'>
            {{#each this.results as |printing|}}
              <div>
                <LinkTo @route='card' @model={{printing.id}}>
                  {{printing.title}}
                </LinkTo>
              </div>
            {{/each}}
          </div>
        {{/if}}
      </div>
    </form>
  </template>
}
