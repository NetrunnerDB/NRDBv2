import { module, test } from 'qunit';

import { setupTest } from 'netrunnerdb/tests/helpers';

module('Unit | Adapter | user', function (hooks) {
  setupTest(hooks);

  // TODO(plural: Replace this with your real tests.
  test('it exists', function (assert) {
    let adapter = this.owner.lookup('adapter:user');
    assert.ok(adapter);
  });
});
