import Component from '@glimmer/component';
import { tracked } from '@glimmer/tracking';
import { action } from '@ember/object';
import { later, next } from '@ember/runloop';
import { htmlSafe } from '@ember/template';

export default class CardImageComponent extends Component {
  @tracked active = false;
  @tracked x;
  @tracked y;
  @tracked t = 0;
  @tracked cooldown;
  runner = null;

  get style() {
    let rotX = (this.t * (this.y - this.height / 2)) / 10;
    let rotY = (this.t * (this.width / 2 - this.x)) / 10;
    let scale = 1 + this.t * 0.05;
    return htmlSafe(
      `transform: scale3d(${scale}, ${scale}, ${scale}) rotateY(${rotY}deg) rotateX(${rotX}deg)`
    );
  }
  get glare() {
    let mx = (100 * this.x) / this.width;
    let my = (100 * this.y) / this.height;
    let opacity = this.active ? 0.35 : 0;
    return htmlSafe(`style: --mx:${mx}%; --my:${my}%; --o: ${opacity}`);
  }

  @action mouseMove(event) {
    this.x = event.layerX;
    this.y = event.layerY;
  }
  @action mouseEnter(event) {
    this.active = true;

    // Record the size of the component
    this.width = event.target.offsetWidth;
    this.height = event.target.offsetHeight;

    // Start animation
    if (this.runner == null) {
      next(this, function () {
        this.runner = this.tick();
      });
    }
  }
  @action mouseLeave() {
    this.active = false;
    this.cooldown = 1;
  }

  // Animate the card manually (using CSS' transition to animate looks janky)
  tick() {
    // Repeat loop until inactive and returned to resting visual state
    if (this.active || this.t > 0) {
      return later(
        this,
        function () {
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
          this.runner = this.tick();
        },
        10
      );
    }
  }
}