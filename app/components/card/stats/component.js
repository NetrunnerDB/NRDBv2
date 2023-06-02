import Component from '@glimmer/component';

export default class CardTextBoxComponent extends Component {
  // TODO: move this to a module or super class
  maybe(val, def = 'X') {
    return val ? val : def;
  }
}
