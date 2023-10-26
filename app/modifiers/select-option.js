import { modifier } from 'ember-modifier';

export default modifier((element, [maxRecords]) => {
  element.querySelector(`option[value="${maxRecords}"]`).selected = true;
});
