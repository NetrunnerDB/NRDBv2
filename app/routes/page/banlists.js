import Route from '@ember/routing/route';
import { service } from '@ember/service';
import RSVP from 'rsvp';

export default class PageBanlistsRoute extends Route {
  @service store;

  async model() {
    let loadedFormats = await Promise.all([
      this.store.findRecord('format', 'startup', { include: 'restrictions' }),
      this.store.findRecord('format', 'standard', { include: 'restrictions' }),
      this.store.findRecord('format', 'eternal', { include: 'restrictions' }),
    ]);

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
          corp: {
            banned: [],
            restricted: [],
            global_penalty: [],
            points: {},
            universal_influence: {},
          },
          runner: {
            banned: [],
            restricted: [],
            global_penalty: [],
            points: {},
            universal_influence: {},
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
      page: { limit: 2000 },
    });

    const cards = new Map();
    cardsQuery.forEach((c) => {
      cards.set(c.cardId, c);
    });

    // Populate the nice versions (TODO: make a better comment)
    formats.forEach((f) => {
      f.restrictions.forEach((r) => {
        r.obj.verdicts['banned'].forEach((b) => {
          const card = cards.get(b);
          if (card.sideId == 'corp') {
            r.corp['banned'].push(card);
          } else if (card.sideId == 'runner') {
            r.runner['banned'].push(card);
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
      });
    });

    /** Desired Data structure:
     formats = []
       'standard' => {
          'obj' => loadedThing,
          'restrictions' => [
            {
              'obj' => loadedThing,
              'corp' => {
                'banned' => [list of cards],
                'restricted' => [list of cards],
                'global_penalty' => [list of cards],
                'points' => {
                  '1' => [list of cards],
                  '2' => [list of cards],
                  '3' => [list of cards]
                },
                'universal_influence' => {
                  '1' => [list of cards],
                  '2' => [list of cards],
                  '3' => [list of cards]
                },
              },
              'runner' => {
                'banned' => [list of cards],
                'restricted' => [list of cards],
                'global_penalty' => [list of cards],
                'points' => {
                  '1' => [list of cards],
                  '2' => [list of cards],
                  '3' => [list of cards]
                },
                'universal_influence' => {
                  '1' => [list of cards],
                  '2' => [list of cards],
                  '3' => [list of cards]
                },
              },
            }
          ]
       },

    */
    return RSVP.hash({
      formats: formats,
      cards: cardsQuery,
    });
  }
}
