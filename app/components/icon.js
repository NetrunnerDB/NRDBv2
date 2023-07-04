import Component from '@glimmer/component';

export default class IconComponent extends Component {
  get id() {
    return this.args.id?.toLowerCase().replace(/[ _]/g, '-');
  }
}
