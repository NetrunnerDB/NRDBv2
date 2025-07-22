import EmberRouter from '@ember/routing/router';
import config from 'netrunnerdb/config/environment';

export default class Router extends EmberRouter {
  location = config.locationType;
  rootURL = config.rootURL;
}

Router.map(function () {
  this.route('home', { path: '/' });
  this.route('decklist', { path: '/decklist/:id' });
  this.route('factions');
  this.route('faction', { path: '/faction/:id' });
  this.route('formats', function () {
    this.route('format', { path: '/:id' });
  });
  this.route('bans');
  this.route('rotation');
  this.route('reviews');
  this.route('rulings');
  this.route('illustrators', function () {
    this.route('illustrator', { path: '/:id' });
  });
  this.route('search');
  this.route('advanced-search', { path: '/advanced-search/:params' });
  this.route('sets');
  this.route('set', { path: '/set/:id' });
  this.route('cycle', { path: '/cycle/:id' });
  this.route('card', { path: '/card/:id' });
  this.route('checkers');

  this.route('decks', function () {
    this.route('index', { path: '/' });
    this.route('deck', { path: '/:id' });
    this.route('new');
  });

  // OLD
  this.route('private', function () {
    this.route('decks');
    this.route('profile');
  });
});
