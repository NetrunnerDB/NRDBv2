import Component from '@glimmer/component';

export default class CardLegalityComponent extends Component {
  get legalityClass() {
    let snapshot = this.args.snapshot;
    let printing = this.args.printing;
    if (!snapshot && !printing) {
      return 'legality-unavailable';
    }
    let validCardPool = printing.snapshotIds.includes(snapshot.id);
    let banned = snapshot.restrictionId
      ? printing.restrictions.banned.includes(snapshot.restrictionId)
      : false;
    let points =
      snapshot.restrictionId in printing.restrictions.points
        ? printing.restrictions.points[snapshot.restrictionId]
        : 0;
    let restricted = snapshot.restrictionId
      ? printing.restrictions.restricted.includes(snapshot.restrictionId)
      : false;
    let globalPenalty =
      snapshot.restrictionId in printing.restrictions.global_penalty;
    let universalFactionCost =
      snapshot.restrictionId in printing.restrictions.universal_faction_cost
        ? printing.restrictions.universal_faction_cost[snapshot.restrictionId]
        : 0;

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
    <div class="text-truncate {{this.legalityClass}}">
      {{! TODO: find a convenient way to get the given card's legality status in the provided format }}
      {{yield}}
    </div>
  </template>
}
