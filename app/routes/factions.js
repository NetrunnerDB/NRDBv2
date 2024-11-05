import Route from '@ember/routing/route';
import { service } from '@ember/service';
import { hash } from 'rsvp';
import Hyphenate from '../utils/hyphenate';

export default class FactionRoute extends Route {
  @service store;

  async model() {
    let factions = await this.store.findAll('faction');
    let descriptions = factions.reduce(function (obj, faction) {
      obj[faction.get('id')] = faction.get('description');
      return obj;
    });

    // Add a hyphenated ID attribute because the hyphenate helper doesn't work because ???
    factions = factions.map((faction) => {
      faction.idHyphenated = Hyphenate(faction.id);
      return faction;
    });

    let runners = factions
      .filter((faction) => faction.sideId == 'runner' && !faction.isMini)
      .sort((a) => (a.id == 'neutral_runner' ? 1 : -1));
    let corps = factions
      .filter((faction) => faction.sideId == 'corp')
      .sort((a) => (a.id == 'neutral_corp' ? 1 : -1));
    let minis = factions.filter((faction) => faction.isMini);

    return hash({
      corps: corps,
      runners: runners,
      minis: minis,
      descriptions: descriptions,
    });
  }
}
