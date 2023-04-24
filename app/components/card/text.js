import Component from '@glimmer/component';

export default class CardTextComponent extends Component {
  get text() {
    if (this.args.text) {
      return (
        '<p>' +
        this.args.text
          .replaceAll('[trash]', '[trash-ability]')
          .replace(/\[([^\d]*?)\]/g, '<i class="icon-$1"></i>') // Convert icons
          .replaceAll('\n', '</p><p>') + // Apply line breaks
        '</p>'
      );
    } else {
      return '';
    }
  }
}
