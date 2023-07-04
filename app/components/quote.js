import Component from '@glimmer/component';

// Note: currently identical to icon.js
export default class QuoteComponent extends Component {
  get id() {
    if (this.args.id) {
      return this.args.id.toLowerCase().replace(/[ _]/g, '-');
    }
  }
}