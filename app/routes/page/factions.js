import Route from '@ember/routing/route';
import { service } from '@ember/service';

export default class PageFactionsRoute extends Route {
  @service store;

  async model() {
    // Get all factions
    let factions = await this.store.findAll('faction', { reload: true });

    // Split factions by side
    let [corp, runner] = factions.reduce(
      ([c, r], e) => (e.sideId == 'corp' ? [[...c, e], r] : [c, [...r, e]]),
      [[], []],
    );

    // Sort the factions
    corp = corp.sort(this.compare);
    runner = runner.sort(this.compare);

    // Additionally split the runner factions into mini and non-mini
    let [rMain, rMini] = runner.reduce(
      ([c, r], e) => (!e.isMini ? [[...c, e], r] : [c, [...r, e]]),
      [[], []],
    );

    // Return all as an object
    return {
      corp: corp,
      runner: runner,
      runnerMain: rMain,
      runnerMini: rMini,
    };
  }

  // Sort by with precedence:
  // - neutral last
  // - then mini below non-mini
  // - then by alphabetic order
  compare(a, b) {
    if (a.id.includes('neutral')) {
      return 1;
    }
    if (b.id.includes('neutral')) {
      return -1;
    }
    if (a.isMini && !b.isMini) {
      return 1;
    }
    if (!a.isMini && b.isMini) {
      return -1;
    }
    return a.name > b.name;
  }
}
