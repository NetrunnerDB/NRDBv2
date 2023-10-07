import { module, test } from 'qunit';
import { setupRenderingTest } from 'netrunnerdb/tests/helpers';
import { render } from '@ember/test-helpers';
import { hbs } from 'ember-cli-htmlbars';

module('Integration | Component | icon', function (hooks) {
  setupRenderingTest(hooks);

  test('it adjusts the id', async function (assert) {
    // Set any properties with this.set('myProperty', 'value');
    // Handle any actions with this.set('myAction', function(val) { ... });

    await render(hbs`
      <Icon @icon="HELLO WORLD" />
    `);

    let icon = this.element.querySelector('i');
    assert.dom(icon).hasClass('icon-hello-world');
    assert.dom(icon).hasClass('hello-world');
  });
});
