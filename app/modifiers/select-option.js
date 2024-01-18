import { modifier } from 'ember-modifier';

export default modifier((element, [value]) => {
  const option = element.querySelector(`option[value="${value}"]`);
  if (option) {
    option.selected = true;
  }
});
