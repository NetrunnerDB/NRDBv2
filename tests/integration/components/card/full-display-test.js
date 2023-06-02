import { module, test } from 'qunit';
import { setupRenderingTest } from 'netrunnerdb/tests/helpers';
import { render } from '@ember/test-helpers';
import { hbs } from 'ember-cli-htmlbars';

module('Integration | Component | card/full-display', function (hooks) {
  setupRenderingTest(hooks);

  test('it renders', async function (assert) {
    // Set any properties with this.set('myProperty', 'value');
    // Handle any actions with this.set('myAction', function(val) { ... });
    this.set('printing', {
      title: 'Monster Mash',
      card: {
        printings: [],
      },
      images: [],
    });

    await render(hbs`<Card::FullDisplay @printing={{this.printing}} />`);

    assert.dom(this.element).exists();
  });
});
