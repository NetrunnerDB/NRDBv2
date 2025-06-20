import { setupTest } from 'netrunnerdb/tests/helpers';
import { module, test } from 'qunit';

module('Unit | Transform | date', function (hooks) {
  setupTest(hooks);

  // Replace this with your real tests.
  test('it exists', function (assert) {
    const transform = this.owner.lookup('transform:date');
    assert.ok(transform, 'transform exists');
  });
});
