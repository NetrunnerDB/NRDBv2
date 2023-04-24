import { module, test } from 'qunit';
import { setupRenderingTest } from 'netrunnerdb/tests/helpers';
import { render } from '@ember/test-helpers';
import { hbs } from 'ember-cli-htmlbars';

module('Integration | Component | card/content', function (hooks) {
  setupRenderingTest(hooks);

  test('it renders', async function (assert) {
    // Set any properties with this.set('myProperty', 'value');
    // Handle any actions with this.set('myAction', function(val) { ... });

    await render(hbs`<Card::Content />`);

    assert.dom(this.element).hasText('');

    // Template block usage:
    await render(hbs`
      <Card::Content>
        template block text
      </Card::Content>
    `);

    assert.dom(this.element).hasText('template block text');
  });
});