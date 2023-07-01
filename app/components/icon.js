import Component from '@glimmer/component';

export default class IconComponent extends Component {
  get id() {
    if (this.args.id) {
      return this.args.id.toLowerCase().replace(/[ _]/g, '-');
    }
  }
}
