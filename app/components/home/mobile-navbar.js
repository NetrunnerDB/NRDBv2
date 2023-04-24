import Component from '@glimmer/component';
import { tracked } from '@glimmer/tracking';
import { action } from '@ember/object';

export default class HomeMobileNavbarComponent extends Component {
  @tracked showDropdown = false;

  @action toggleDropdown() {
    this.showDropdown = !this.showDropdown;
  }

  @action openDropdown() {
    this.showDropdown = true;
  }

  @action closeDropdown() {
    this.showDropdown = false;
  }
}
