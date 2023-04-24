import Component from '@glimmer/component';
import { htmlSafe } from '@ember/template';

export default class CardTextComponent extends Component {
  get processedText() {
    return htmlSafe(
      this.args.text
        .replaceAll('[trash]', '[trash-ability]')
        .replace(/\[([^\d]*?)\]/g, '<i class="icon-$1"></i>') // Convert icons
        .replaceAll('\n', '</p><p>')
    );
  }
}
