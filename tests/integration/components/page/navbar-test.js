import { module, test } from 'qunit';
import { setupRenderingTest } from 'netrunnerdb/tests/helpers';
import { render } from '@ember/test-helpers';
import { hbs } from 'ember-cli-htmlbars';

module('Integration | Component | page/navbar', function (hooks) {
  setupRenderingTest(hooks);

  test('it renders', async function (assert) {
    // Set any properties with this.set('myProperty', 'value');
    // Handle any actions with this.set('myAction', function(val) { ... });

    await render(hbs`<Page::Navbar />`);

    assert.dom(this.element).exists();
  });
});
