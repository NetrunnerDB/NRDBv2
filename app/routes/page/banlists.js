import Route from '@ember/routing/route';
import { service } from '@ember/service';
import RSVP from 'rsvp';

export default class PageBanlistsRoute extends Route {
  @service store;

  capitalize(text) {
    return text.charAt(0).toUpperCase() + text.substr(1);
  }

  async model() {
    let loadedFormats = await this.store.query('format', {
      filter: { id: ['startup', 'standard', 'eternal'] },
      include: ['restrictions'],
      sort: '-id',
    });

    const cardIds = new Set();
    const formats = [];
    loadedFormats.forEach((format) => {
      const f = {
        id: format.id,
        name: format.name,
        obj: format,
        restrictions: [],
      };
      formats.push(f);
      format.restrictions.forEach((restriction) => {
        f['restrictions'].push({
          id: restriction.id,
          name: restriction.name,
          obj: restriction,
          dateStart: restriction.dateStart,
          hasPoints: false,
          hasUniversalInfluence: false,
          // This is less general, but we currently only have 1 banned subtype.
          banned_subtype: restriction.bannedSubtypes.length
            ? restriction.bannedSubtypes[0]
            : null,
          formatted_banned_subtype: restriction.bannedSubtypes.length
            ? this.capitalize(restriction.bannedSubtypes[0])
            : null,
          corp: {
            banned: [],
            restricted: [],
            global_penalty: [],
            onePoint: [],
            twoPoints: [],
            threePoints: [],
            oneUniversalInfluence: [],
            threeUniversalInfluence: [],
          },
          runner: {
            banned: [],
            restricted: [],
            global_penalty: [],
            onePoint: [],
            twoPoints: [],
            threePoints: [],
            oneUniversalInfluence: [],
            threeUniversalInfluence: [],
          },
        });
        restriction.verdicts.banned.forEach((cardId) => {
          cardIds.add(cardId);
        });
        restriction.verdicts.restricted.forEach((cardId) => {
          cardIds.add(cardId);
        });
        restriction.verdicts.global_penalty.forEach((cardId) => {
          cardIds.add(cardId);
        });
        for (let cardId in restriction.verdicts.points) {
          cardIds.add(cardId);
        }
        for (let cardId in restriction.verdicts.universal_faction_cost) {
          cardIds.add(cardId);
        }
      });
    });
    let cardsQuery = await this.store.query('printing', {
      filter: {
        card_id: Array.from(cardIds.keys()).sort().join(','),
        distinct_cards: true,
      },
      include: ['card', 'card_set', 'card_type', 'faction'],
      page: { size: 2000 },
    });

    const cards = new Map();
    cardsQuery.forEach((c) => {
      cards.set(c.cardId, c);
    });

    formats.forEach((f) => {
      f.restrictions.forEach((r) => {
        r.obj.verdicts['banned'].forEach((b) => {
          const card = cards.get(b);
          if (card.cardSubtypeIds.indexOf(r.banned_subtype) == -1) {
            if (card.sideId == 'corp') {
              r.corp['banned'].push(card);
            } else if (card.sideId == 'runner') {
              r.runner['banned'].push(card);
            }
          }
        });
        r.obj.verdicts['restricted'].forEach((b) => {
          const card = cards.get(b);
          if (card.sideId == 'corp') {
            r.corp['restricted'].push(card);
          } else if (card.sideId == 'runner') {
            r.runner['restricted'].push(card);
          }
        });
        r.obj.verdicts['global_penalty'].forEach((b) => {
          const card = cards.get(b);
          if (card.sideId == 'corp') {
            r.corp['global_penalty'].push(card);
          } else if (card.sideId == 'runner') {
            r.runner['global_penalty'].push(card);
          }
        });
        for (let cardId in r.obj.verdicts.points) {
          r.hasPoints = true;
          let card = cards.get(cardId);
          let points = r.obj.verdicts.points[cardId];
          if (card.sideId == 'corp') {
            if (points == 1) {
              r.corp.onePoint.push(card);
            } else if (points == 2) {
              r.corp.twoPoints.push(card);
            } else if (points == 3) {
              r.corp.threePoints.push(card);
            }
          } else if (card.sideId == 'runner') {
            if (points == 1) {
              r.runner.onePoint.push(card);
            } else if (points == 2) {
              r.runner.twoPoints.push(card);
            } else if (points == 3) {
              r.runner.threePoints.push(card);
            }
          }
        }
        for (let cardId in r.obj.verdicts.universal_faction_cost) {
          r.hasUniversalInfluence = true;
          let card = cards.get(cardId);
          let cost = r.obj.verdicts.universal_faction_cost[cardId];
          if (card.sideId == 'corp') {
            if (cost == 1) {
              r.corp.oneUniversalInfluence.push(card);
            } else if (cost == 3) {
              r.corp.threeUniversalInfluence.push(card);
            }
          } else if (card.sideId == 'runner') {
            if (cost == 1) {
              r.runner.oneUniversalInfluence.push(card);
            } else if (cost == 3) {
              r.runner.threeUniversalInfluence.push(card);
            }
          }
        }
      });
    });

    return RSVP.hash({
      formats: formats,
      cards: cardsQuery,
    });
  }
}
