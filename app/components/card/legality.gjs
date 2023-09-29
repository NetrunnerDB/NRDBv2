import Component from '@glimmer/component';
import { tracked } from '@glimmer/tracking';

export default class CardLegalityComponent extends Component {
  get legalityClass() {
    let validCardPool = this.args.printing.snapshotIds.includes(this.args.snapshot.id);
    let banned = this.args.snapshot.restrictionId ? this.args.printing.restrictions.banned.includes(this.args.snapshot.restrictionId) : false;
    let points = (this.args.snapshot.restrictionId in this.args.printing.restrictions.points) ? this.args.printing.restrictions.points[this.args.snapshot.restrictionId] : 0;
    let restricted = this.args.snapshot.restrictionId ? this.args.printing.restrictions.restricted.includes(this.args.snapshot.restrictionId) : false;
    let globalPenalty = this.args.snapshot.restrictionId in this.args.printing.restrictions.global_penalty;
    let universalFactionCost = (this.args.snapshot.restrictionId in this.args.printing.restrictions.universal_faction_cost) ? this.args.printing.restrictions.universal_faction_cost[this.args.snapshot.restrictionId] : 0;

    let legality = 'legality-legal';
    if (!validCardPool) {
      legality = 'legality-unavailable';
    } else if (banned) {
      legality = 'legality-banned';
    } else if (points) {
      legality = `legality-points-${points}`;
    } else if (restricted) {
      legality = 'legality-restricted';
    } else if (globalPenalty) {
      legality = `legality-penalty`;
    } else if (universalFactionCost) {
      legality = `legality-${universalFactionCost}-inf`;
    }
    return legality;
  }

  <template>
    <div class="text-truncate {{ this.legalityClass }}">
      {{! TODO: find a convenient way to get the given card's legality status in the provided format }}
      {{yield}}
    </div>
  </template>
}
