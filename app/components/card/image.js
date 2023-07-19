import Component from '@glimmer/component';
import { tracked } from '@glimmer/tracking';
import { action } from '@ember/object';

export default class CardImageComponent extends Component {
  @tracked active = false;
  @tracked x;
  @tracked y;
  @tracked t = 0;
  @tracked cooldown;
  @tracked containerStyle;

  updateGlare() {
    let mx = (100 * this.x) / this.width;
    let my = (100 * this.y) / this.height;
    let opacity = this.active ? 0.35 : 0;

    this.containerStyle.style.setProperty('--mx', `${mx}%`);
    this.containerStyle.style.setProperty('--my', `${my}%`);
    this.containerStyle.style.setProperty('--o', opacity);
  }

  updateArtFrame() {
    let rotX = (this.t * (this.y - this.height / 2)) / 10;
    let rotY = (this.t * (this.width / 2 - this.x)) / 10;
    let scale = 1 + this.t * 0.05;

    this.containerStyle.style.setProperty('--scale', scale);
    this.containerStyle.style.setProperty('--rotate-x', `${rotX}deg`);
    this.containerStyle.style.setProperty('--rotate-y', `${rotY}deg`);
  }

  get src() {
    const printing = this.args.card 
      ? this.args.card.printings[0]
      : this.args.printing;
    const size = this.args.size ?? 'medium';

    return printing 
      ? printing.images.nrdb_classic[size]
      : ''
  }

  @action mouseMove(event) {
    this.x = event.layerX;
    this.y = event.layerY;
  }

  @action mouseEnter(event) {
    this.active = true;

    // Cache reference to element
    this.containerStyle = event.target;

    // Record the size of the component
    this.width = event.target.offsetWidth;
    this.height = event.target.offsetHeight;

    // Start animation
    window.requestAnimationFrame(this.tick);
  }
  @action mouseLeave() {
    this.active = false;
    this.cooldown = 1;
  }

  // Animate the card manually (using CSS' transition to animate looks janky)
  @action tick() {
    // Repeat loop until inactive and returned to resting visual state
    if (this.active || this.t > 0) {
      if (this.active) {
        this.t = Math.min(1, this.t + 0.1);
      } else if (this.cooldown <= 0) {
        this.t = Math.max(0, this.t - 0.05);
      } else if (this.cooldown < 0.5) {
        this.cooldown -= 0.05;
        this.t = Math.max(0, this.t - 0.01);
      } else {
        this.cooldown -= 0.05;
      }

      this.updateGlare();
      this.updateArtFrame();
      window.requestAnimationFrame(this.tick);
    }
  }
}
