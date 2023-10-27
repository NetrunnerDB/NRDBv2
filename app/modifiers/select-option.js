import { modifier } from 'ember-modifier';

export default modifier((element, [value]) => {
  element.querySelector(`option[value="${value}"]`).selected = true;
});
