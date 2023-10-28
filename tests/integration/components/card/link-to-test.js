import { module, test } from 'qunit';
import { setupRenderingTest } from 'netrunnerdb/tests/helpers';
import { render } from '@ember/test-helpers';
import { hbs } from 'ember-cli-htmlbars';

module('Integration | Component | card/link-to', function (hooks) {
  setupRenderingTest(hooks);

  test('it accepts a printing', async function (assert) {
    // Set any properties with this.set('myProperty', 'value');
    // Handle any actions with this.set('myAction', function(val) { ... });
    this.set('model', {
      id: 1,
      cardTypeId: 1,
    });

    await render(hbs`
      <Card::LinkTo @printing={{this.model}} @hideTooltip={{true}}>
        Message
      </Card::LinkTo>
    `);

    assert.dom(this.element).hasText('Message');
  });

  // TODO add test for numeric id and generic string id.
  // Since they make network requests, we will need to stub them out.
});
