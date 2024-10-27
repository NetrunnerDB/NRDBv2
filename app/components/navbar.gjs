import Component from '@glimmer/component';
import { tracked } from '@glimmer/tracking';
import { action } from '@ember/object';
import { LinkTo } from '@ember/routing';
import { on } from '@ember/modifier';
import FaIcon from '@fortawesome/ember-fontawesome/components/fa-icon';
import Collapse from 'ember-bootstrap/components/bs-collapse';

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
      <div class='container'>
        <div class='row'>
          <div class='col-12 col-lg-3 mb-4 mb-lg-0'>
            <LinkTo @route='home' class='navbar-brand'>
              <img src='/assets/image/logo.png' alt='NetrunnerDB' />
              <span>NetrunnerDB</span>
            </LinkTo>
            <div class='col-2 d-lg-none float-end'>
              <button
                class='navbar-toggler me-2 float-end'
                type='button'
                {{on 'click' this.toggleDropdown}}
              >
                <FaIcon @icon='bars' />
              </button>
            </div>
            <div class='d-lg-none'>
              <Collapse @collapsed={{this.isCollapsed}} class='navbar-collapse'>
                <ul
                  class='navbar-nav text-center'
                  {{on 'click' this.closeDropdown}}
                >
                  <li class='nav-item nav-link-container'>
                    <LinkTo @route='home' class='nav-link button-link'>
                      Home
                    </LinkTo>
                  </li>
                  <li class='nav-item nav-link-container'>
                    <LinkTo @route='home' class='nav-link button-link'>
                      Register/Login
                    </LinkTo>
                  </li>
                  <li class='nav-item nav-link-container'>
                    <LinkTo @route='home' class='nav-link button-link'>
                      My Decks
                    </LinkTo>
                  </li>
                  <li class='nav-item nav-link-container'>
                    <LinkTo @route='home' class='nav-link button-link'>
                      Decklists
                    </LinkTo>
                  </li>
                  <li class='nav-item nav-link-container'>
                    <LinkTo @route='home' class='nav-link button-link'>
                      Sets
                    </LinkTo>
                  </li>
                  <li class='nav-item nav-link-container'>
                    <LinkTo @route='factions' class='nav-link button-link'>
                      Factions
                    </LinkTo>
                  </li>
                  <li class='nav-item nav-link-container'>
                    <LinkTo @route='formats' class='nav-link button-link'>
                      Formats
                    </LinkTo>
                  </li>
                  <li class='nav-item nav-link-container'>
                    <LinkTo @route='bans' class='nav-link button-link'>
                      Bans
                    </LinkTo>
                  </li>
                  <li class='nav-item nav-link-container'>
                    <LinkTo @route='rotation' class='nav-link button-link'>
                      Rotation
                    </LinkTo>
                  </li>
                  <li class='nav-item nav-link-container'>
                    <LinkTo @route='reviews' class='nav-link button-link'>
                      Reviews
                    </LinkTo>
                  </li>
                  <li class='nav-item nav-link-container'>
                    <LinkTo @route='rulings' class='nav-link button-link'>
                      Rulings
                    </LinkTo>
                  </li>
                  <li class='nav-item nav-link-container'>
                    <LinkTo @route='illustrators' class='nav-link button-link'>
                      Illustrators
                    </LinkTo>
                  </li>
                </ul>
              </Collapse>
            </div>
          </div>

          <div class='col-12 col-lg-6'>
            <form>
              <input class='w-100' type='text' placeholder='Search' />
            </form>
          </div>

          <div class='col-3 visible-lg text-end mt-3 mt-sm-0'>
            <div class='row'>
              <div class='col-xl-4 offset-xl-4 col-lg-5 offset-lg-2 col-6'>
                <LinkTo
                  @route='home'
                  class='button d-block grey cyber'
                >Register</LinkTo>
              </div>
              <div class='col-xl-4 col-lg-5 col-6'>
                <LinkTo
                  @route='home'
                  class='button d-block blue cyber'
                >Login</LinkTo>
              </div>
            </div>
          </div>
        </div>
      </div>
    </nav>

    <nav id='bottom-nav' class='col visible-lg py-2 font-size-14'>
      <div class='container py-2'>
        <div class='row'>
          <div class='col'>
            <LinkTo @route='home'>Home</LinkTo>
          </div>
          <div class='col'>
            <LinkTo @route='home'>My Decks</LinkTo>
          </div>
          <div class='col'>
            <LinkTo @route='home'>Decklists</LinkTo>
          </div>
          <div class='col'>
            <LinkTo @route='sets'>Sets</LinkTo>
          </div>
          <div class='col'>
            <LinkTo @route='factions'>Factions</LinkTo>
          </div>
          <div class='col'>
            <LinkTo @route='formats'>Formats</LinkTo>
          </div>
          <div class='col'>
            <LinkTo @route='bans'>Bans</LinkTo>
          </div>
          <div class='col'>
            <LinkTo @route='rotation'>Rotation</LinkTo>
          </div>
          <div class='col'>
            <LinkTo @route='reviews'>Reviews</LinkTo>
          </div>
          <div class='col'>
            <LinkTo @route='rulings'>Rulings</LinkTo>
          </div>
          <div class='col'>
            <LinkTo @route='illustrators'>Illustrators</LinkTo>
          </div>
        </div>
      </div>
    </nav>
  </template>
}

export default Navbar;
