import { module, test } from 'qunit';

import { setupTest } from 'netrunnerdb/tests/helpers';

module('Unit | Model | card cycle', function (hooks) {
  setupTest(hooks);

  // Replace this with your real tests.
  test('it exists', function (assert) {
    let store = this.owner.lookup('service:store');
    let model = store.createRecord('card-cycle', {});
    assert.ok(model);
  });
});
