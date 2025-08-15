import Component from '@glimmer/component';
import { tracked } from '@glimmer/tracking';
import { action } from '@ember/object';
import { LinkTo } from '@ember/routing';
import NavbarSearch from 'netrunnerdb/components/search/navbar-search';
import { on } from '@ember/modifier';
import FaIcon from '@fortawesome/ember-fontawesome/components/fa-icon';
import {
  faBars,
  faFantasyFlightGames,
} from '@fortawesome/free-solid-svg-icons';

import Collapse from 'ember-bootstrap/components/bs-collapse';
import formatMessage from 'ember-intl/helpers/format-message';

class Navbar extends Component {
  @tracked showDropdown = false;

  get isCollapsed() {
    return !this.showDropdown;
  }

  @action toggleDropdown() {
    this.showDropdown = !this.showDropdown;
  }

  @action closeDropdown() {
    this.showDropdown = false;
  }

  <template>
    <nav id='top-nav' class='col py-4'>
      <FaIcon @icon={{faFantasyFlightGames}} />

      <div class='container'>
        <div class='row'>
          <div class='col-12 col-lg-3 mb-4 mb-lg-0'>
            <LinkTo @route='home' class='navbar-brand'>
              <img src='/assets/image/logo.png' alt='NetrunnerDB' />
              <span>{{formatMessage 'NetrunnerDB'}}</span>
            </LinkTo>
            <div class='col-2 d-lg-none float-end'>
              <button
                class='navbar-toggler me-2 float-end'
                type='button'
                {{on 'click' this.toggleDropdown}}
              >
                <FaIcon @icon={{faBars}} />
              </button>
            </div>
            <div class='d-lg-none'>
              <Collapse @collapsed={{this.isCollapsed}} class='navbar-collapse'>
                {{! template-lint-disable no-invalid-interactive }}
                <ul
                  class='navbar-nav text-center'
                  {{on 'click' this.closeDropdown}}
                >
                  <li class='nav-item nav-link-container'>
                    <LinkTo @route='home' class='nav-link button-link'>
                      {{formatMessage 'Home'}}
                    </LinkTo>
                  </li>
                  <li class='nav-item nav-link-container'>
                    <LinkTo @route='home' class='nav-link button-link'>
                      {{formatMessage 'Register/Login'}}
                    </LinkTo>
                  </li>
                  <li class='nav-item nav-link-container'>
                    <LinkTo @route='home' class='nav-link button-link'>
                      {{formatMessage 'My Decks'}}
                    </LinkTo>
                  </li>
                  <li class='nav-item nav-link-container'>
                    <LinkTo @route='home' class='nav-link button-link'>
                      {{formatMessage 'Decklists'}}
                    </LinkTo>
                  </li>
                  <li class='nav-item nav-link-container'>
                    <LinkTo @route='home' class='nav-link button-link'>
                      {{formatMessage 'Sets'}}
                    </LinkTo>
                  </li>
                  <li class='nav-item nav-link-container'>
                    <LinkTo @route='factions' class='nav-link button-link'>
                      {{formatMessage 'Factions'}}
                    </LinkTo>
                  </li>
                  <li class='nav-item nav-link-container'>
                    <LinkTo @route='formats' class='nav-link button-link'>
                      {{formatMessage 'Formats'}}
                    </LinkTo>
                  </li>
                  <li class='nav-item nav-link-container'>
                    <LinkTo @route='bans' class='nav-link button-link'>
                      {{formatMessage 'Bans'}}
                    </LinkTo>
                  </li>
                  <li class='nav-item nav-link-container'>
                    <LinkTo @route='rotation' class='nav-link button-link'>
                      {{formatMessage 'Rotation'}}
                    </LinkTo>
                  </li>
                  <li class='nav-item nav-link-container'>
                    <LinkTo @route='reviews' class='nav-link button-link'>
                      {{formatMessage 'Reviews'}}
                    </LinkTo>
                  </li>
                  <li class='nav-item nav-link-container'>
                    <LinkTo @route='rulings' class='nav-link button-link'>
                      {{formatMessage 'Rulings'}}
                    </LinkTo>
                  </li>
                  <li class='nav-item nav-link-container'>
                    <LinkTo @route='illustrators' class='nav-link button-link'>
                      {{formatMessage 'Illustrators'}}
                    </LinkTo>
                  </li>
                </ul>
              </Collapse>
            </div>
          </div>

          <div class='col-12 col-lg-6'>
            <NavbarSearch />
          </div>

          <div class='col-3 visible-lg text-end mt-3 mt-sm-0'>
            <div class='row'>
              <div class='col-xl-4 offset-xl-4 col-lg-5 offset-lg-2 col-6'>
                <LinkTo
                  @route='home'
                  class='button d-block grey cyber'
                >{{formatMessage 'Register'}}</LinkTo>
              </div>
              <div class='col-xl-4 col-lg-5 col-6'>
                <LinkTo
                  @route='home'
                  class='button d-block blue cyber'
                >{{formatMessage 'Login'}}</LinkTo>
              </div>
            </div>
          </div>
        </div>
      </div>
    </nav>

    {{! template-lint-disable no-duplicate-landmark-elements }}
    <nav id='bottom-nav' class='col visible-lg py-2 font-size-14'>
      <div class='container py-2'>
        <div class='row'>
          <div class='col'>
            <LinkTo @route='home'>{{formatMessage 'Home'}}</LinkTo>
          </div>
          <div class='col'>
            <LinkTo @route='home'>{{formatMessage 'My Decks'}}</LinkTo>
          </div>
          <div class='col'>
            <LinkTo @route='home'>{{formatMessage 'Decklists'}}</LinkTo>
          </div>
          <div class='col'>
            <LinkTo @route='sets'>{{formatMessage 'Sets'}}</LinkTo>
          </div>
          <div class='col'>
            <LinkTo @route='factions'>{{formatMessage 'Factions'}}</LinkTo>
          </div>
          <div class='col'>
            <LinkTo @route='formats'>{{formatMessage 'Formats'}}</LinkTo>
          </div>
          <div class='col'>
            <LinkTo @route='bans'>{{formatMessage 'Bans'}}</LinkTo>
          </div>
          <div class='col'>
            <LinkTo @route='rotation'>{{formatMessage 'Rotation'}}</LinkTo>
          </div>
          <div class='col'>
            <LinkTo @route='reviews'>{{formatMessage 'Reviews'}}</LinkTo>
          </div>
          <div class='col'>
            <LinkTo @route='rulings'>{{formatMessage 'Rulings'}}</LinkTo>
          </div>
          <div class='col'>
            <LinkTo @route='illustrators'>
              {{formatMessage 'Illustrators'}}
            </LinkTo>
          </div>
        </div>
      </div>
    </nav>
  </template>
}

export default Navbar;
