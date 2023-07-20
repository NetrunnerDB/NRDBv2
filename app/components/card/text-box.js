import Component from '@glimmer/component';
import maybe from 'netrunnerdb/utils/maybe';

export default class CardTextBoxComponent extends Component {
  get stats() {
    let card = this.args.printing;
    let stats = '';
    switch (card.cardTypeId) {
      case 'corp_identity':
        stats = `${card.minimumDeckSize}/${maybe(
          card.influenceLimit,
          '∞'
        )}`;
        break;
      case 'runner_identity':
        stats = `${card.minimumDeckSize}/${maybe(
          card.influenceLimit,
          '∞',
        )} ${card.baseLink}<i class="icon-link"></i>`;
        break;
      case 'agenda':
        stats = `${maybe(card.advancementRequirement)}/${
          card.agendaPoints
        }<i class="icon-agenda-points"></i>`;
        break;
      default:
        stats = `
          ${card.cost >= 0 ? card.cost : 'X'}<i class="icon-credit"></i>
          ${card.memoryCost ? ` ${card.memoryCost}<i class="icon-mu"></i>` : ''}
          ${
            card.trashCost
              ? ` ${card.trashCost}<i class="icon-trash-cost"></i>`
              : ''
          }
          ${card.strength ? `<br>Strength: ${card.strength}` : ''}
        `;
        break;
    }
    return stats;
  }
}
