import { module, test } from 'qunit';
import { setupRenderingTest } from 'ember-qunit';
import { render } from '@ember/test-helpers';
import { hbs } from 'ember-cli-htmlbars';

module('Integration | Modifier | select-option', function (hooks) {
  setupRenderingTest(hooks);

  // Replace this with your real tests.
  test('it renders', async function (assert) {
    await render(
      hbs`<select id="test_select" {{select-option 25}}><option value="">Default</option><option value="5">5</option><option value="25">25</option><option value="50">50</option></select>`,
    );

    assert.dom('#test_select').hasValue('25');
  });
});
