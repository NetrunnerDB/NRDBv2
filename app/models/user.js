import Model, { attr } from '@ember-data/model';

export default class UserModel extends Model {
  query() {
    return fetch('/user').then(function (users) {
      return users.length == 1 ? users[0] : {};
    });
  }
  @attr username;
}
