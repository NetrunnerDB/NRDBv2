import Route from '@ember/routing/route';
import { service } from '@ember/service';
import { hash } from 'rsvp';

export default class CardRoute extends Route {
  @service store;

  async model(params) {
    let id = params.id;

    // Card pages always default to the latest printing of a card unless
    // a specific printing is specified.  This only affects some elements
    // on the page, however.

    let card = undefined;
    let printing = undefined;
    let allPrintings = undefined;

    // Printing Code - load card via printing.
    if (id.match(/^\d{5}$/)) {
      // Get the printing
      printing = await this.store.findRecord('printing', id, {
        include:
          'card_set,card_type,faction,card,card.rulings,card.reviews,card.printings',
      });
      card = printing.card;
      id = card.id;
      // this was done because of an ember warning.
      allPrintings = card.get('printings');
    } else {
      card = await this.store.findRecord('card', id, {
        include: ['card_sets,card_type,faction,printings,reviews,rulings'],
      });
      id = card.id;
      allPrintings = card.printings;
      printing = card.latestPrinting;
      console.log(printing);
    }

    let cardSetPrintings = await this.store.query('printing', {
      filter: { card_set_id: printing.cardSetId },
      page: { size: 1000 },
      sort: 'position',
    });

    // Identify previous and next printings in the set.
    let prevPrinting = null;
    let nextPrinting = null;
    cardSetPrintings.forEach((p) => {
      if (printing.id > p.id) {
        prevPrinting = p;
      }
      if (!nextPrinting && printing.id < p.id) {
        nextPrinting = p;
      }
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

    let rulings = card.get('rulings');
    let reviews = card.get('reviews');

    return hash({
      card,
      printing,
      allPrintings,
      nextPrinting,
      prevPrinting,
      standardSnapshot,
      startupSnapshot,
      eternalSnapshot,
      reviews,
      rulings,
    });
  }
}
