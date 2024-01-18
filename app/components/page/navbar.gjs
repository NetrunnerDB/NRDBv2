import Component from '@glimmer/component';
import { tracked } from '@glimmer/tracking';
import { action } from '@ember/object';
import { LinkTo } from '@ember/routing';
import { on } from '@ember/modifier';
import Collapse from 'ember-bootstrap/components/bs-collapse';
import Dropdown from 'ember-bootstrap/components/bs-dropdown';
import FaIcon from '@fortawesome/ember-fontawesome/components/fa-icon';
import { service } from '@ember/service';

export default class PageNavbarComponent extends Component {
  @service router;
  @tracked showDropdown = false;
  @tracked query = '';

  get isCollapsed() {
    return !this.showDropdown;
  }

  @action toggleDropdown() {
    this.showDropdown = !this.showDropdown;
  }

  @action closeDropdown() {
    this.showDropdown = false;
  }

  @action doSearch(e) {
    e.preventDefault();

    const query = e.target.query.value;

    // Reset the search bar.
    e.target.query.value = '';

    this.router.transitionTo('page.basic-search', {
      queryParams: { query: query },
    });
  }

  <template>
    <header class='container'>
      <div class='row sticky-top'>
        <div class='col-md-12 d-flex flex-column px-0'>
          <nav class='navbar navbar-expand-md bg-white shadow py-md-0'>
            <div class='container-fluid px-0'>
              <LinkTo @route='home' class='navbar-brand ms-3'>
                <img src='/assets/images/logo.png' alt='NetrunnerDB' />
                <span class='d-md-none d-lg-inline-block'>NetrunnerDB</span>
              </LinkTo>
              <button
                class='navbar-toggler me-2'
                type='button'
                {{on 'click' this.toggleDropdown}}
              >
                <span class='navbar-toggler-icon'></span>
              </button>
              <Collapse
                @collapsed={{this.isCollapsed}}
                class='navbar-collapse d-md-flex'
              >
                <div class='navbar-nav flex-grow-1 pe-md-4'>
                  <form
                    id='card-search-bar'
                    class='form-inline w-100 my-3 my-md-0'
                    {{on 'submit' this.doSearch}}
                  >
                    <div class='input-group'>
                      <input
                        id='query'
                        type='text'
                        class='form-control p-relative py-3'
                        placeholder='Search for card...'
                      />
                    </div>
                  </form>
                </div>
                {{! template-lint-disable no-invalid-interactive }}
                <ul
                  class='navbar-nav me-auto pb-2 pb-md-0'
                  {{on 'click' this.closeDropdown}}
                >
                  <li class='nav-item'>
                    <LinkTo
                      @route='page.syntax'
                      class='nav-link button-link px-2 p-md-3'
                    ><FaIcon @icon='key' class='d-md-none d-xl-inline-block' />
                      Syntax</LinkTo>
                  </li>
                  <li class='nav-item'>
                    <LinkTo
                      @route='page.advanced-search'
                      class='nav-link button-link px-2 p-md-3'
                    ><FaIcon
                        @icon='magnifying-glass'
                        class='d-md-none d-xl-inline-block'
                      />
                      Advanced</LinkTo>
                  </li>
                  <li class='nav-item d-none d-lg-inline-block'>
                    <LinkTo
                      @route='page.card'
                      @model='rng_key'
                      class='nav-link button-link px-2 p-md-3'
                    ><FaIcon @icon='dice' class='d-md-none d-xl-inline-block' />
                      Random</LinkTo>
                  </li>
                  <li class='nav-item'>
                    <Dropdown as |dd|>
                      <dd.toggle class='nav-link button-link px-2 p-md-3'>
                        <FaIcon
                          @icon='map'
                          class='d-md-none d-xl-inline-block'
                        />
                        Explore
                        <span class='caret'></span></dd.toggle>
                      <dd.menu class='nav-item-menu' as |ddm|>
                        <ddm.item>
                          <ddm.linkTo
                            class='nav-link button-link px-2 px-md-3'
                            @route='page.factions'
                            {{on 'click' this.closeDropdown}}
                          >Factions</ddm.linkTo>
                        </ddm.item>
                        <ddm.item>
                          <ddm.linkTo
                            class='nav-link button-link px-2 px-md-3'
                            @route='page.formats'
                            {{on 'click' this.closeDropdown}}
                          >Formats</ddm.linkTo>
                        </ddm.item>
                        <ddm.item>
                          <ddm.linkTo
                            class='nav-link button-link px-2 px-md-3'
                            @route='page.banlists'
                            {{on 'click' this.closeDropdown}}
                          >Ban Lists</ddm.linkTo>
                        </ddm.item>
                        <ddm.item>
                          <ddm.linkTo
                            class='nav-link button-link px-2 px-md-3'
                            @route='page.illustrators'
                            {{on 'click' this.closeDropdown}}
                          >Illustrators</ddm.linkTo>
                        </ddm.item>
                        <ddm.item>
                          <ddm.linkTo
                            class='nav-link button-link px-2 px-md-3'
                            @route='page.sets'
                            {{on 'click' this.closeDropdown}}
                          >Sets</ddm.linkTo>
                        </ddm.item>
                        <ddm.item>
                          <ddm.linkTo
                            class='nav-link button-link px-2 px-md-3'
                            @route='page.reviews'
                            {{on 'click' this.closeDropdown}}
                          >Reviews</ddm.linkTo>
                        </ddm.item>
                        <ddm.item>
                          <ddm.linkTo
                            class='nav-link button-link px-2 px-md-3'
                            @route='page.rulings'
                            {{on 'click' this.closeDropdown}}
                          >Rulings</ddm.linkTo>
                        </ddm.item>
                      </dd.menu>
                    </Dropdown>
                  </li>
                  <li class='nav-item ms-md-4 me-md-0'>
                    <LinkTo
                      @route='home'
                      class='nav-link button-link px-2 p-md-3 text-center-sm'
                    ><FaIcon @icon='user' />
                      <span class='d-md-none'> Random</span></LinkTo>
                  </li>
                </ul>
              </Collapse>
            </div>
          </nav>
        </div>
      </div>
    </header>
  </template>
}
