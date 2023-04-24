import Route from '@ember/routing/route';
import { service } from '@ember/service';
// import RSVP from 'rsvp';

export default class CardRoute extends Route {
  @service store;

  async model(params) {
    let id = params.id;

    // Card pages display a printing, not an abstract card
    // If the given ID is not a printing ID, treat it as a card ID and find its latest printing
    if (isNaN(parseInt(id))) {
      let parsed = await this.store.findRecord('card', id);
      id = parsed.get('latestPrintingId');
    }

    // Get the printing
    let printing = await this.store.findRecord('printing', id, {
      include: 'faction,card_set', // Should also include card_type but that relation hasn't been implemented yet
    });
    return printing;

    // // Get its set
    // let cardSet = this.store.findRecord('card_set', printing.get('cardSetId'), {
    //   include: 'printings',
    // });

    // // Get its faction and type
    // let faction = this.store.findRecord('faction', printing.get('factionId'));
    // let cardType = this.store.findRecord(
    //   'card_type',
    //   printing.get('cardTypeId')
    // );

    // return RSVP.hash({
    //   printing: printing,
    //   // faction: faction,
    //   // cardSet: cardSet,
    //   // cardType: cardType
    // });
  }
}
