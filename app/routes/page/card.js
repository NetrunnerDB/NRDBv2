import Route from '@ember/routing/route';
import { service } from '@ember/service';
import { hash } from 'rsvp';

export default class PageCardRoute extends Route {
  @service store;

  async model(params) {
    let id = params.id;

    // Card pages display a printing, not an abstract card
    // If the given ID is not a printing ID, treat it as a card ID and find its latest printing
    let card = undefined;
    if (isNaN(parseInt(id))) {
      card = await this.store.findRecord('card', id);
      id = card.latestPrintingId;
    }

    // Get the printing
    let printing = await this.store.findRecord('printing', id, {
      include: 'card_set,card_type,faction,card,card.rulings',
    });
    if (!card) {
      card = await printing.card;
    }
    let cardSet = await printing.cardSet;
    let cardType = await printing.cardType;
    let faction = await printing.faction;
    let rulings = await card.rulings;

    let otherPrintings = await this.store.query('printing', {
      filter: { card_id: printing.cardId },
      sort: '-id',
    });

    // Fetch active snapshots for the 3 main formats.
    let formats = await this.store.query('snapshot', {
      filter: { active: true, format_id: ['eternal', 'standard', 'startup'] },
    });
    let eternalSnapshot = undefined;
    let standardSnapshot = undefined;
    let startupSnapshot = undefined;
    formats.forEach((f) => {
      if (f.formatId == 'eternal') {
        eternalSnapshot = f;
      } else if (f.formatId == 'standard') {
        standardSnapshot = f;
      } else if (f.formatId == 'startup') {
        startupSnapshot = f;
      }
    });

    return hash({
      card,
      cardSet,
      cardType,
      eternalSnapshot,
      faction,
      otherPrintings,
      printing,
      rulings,
      standardSnapshot,
      startupSnapshot,
    });
  }
}
