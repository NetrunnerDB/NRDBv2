import { module, test } from 'qunit';
import { setupTest } from 'netrunnerdb/tests/helpers';

module('Unit | Route | page/faction', function (hooks) {
  setupTest(hooks);

  test('it exists', function (assert) {
    let route = this.owner.lookup('route:page/faction');
    assert.ok(route);
  });
});
