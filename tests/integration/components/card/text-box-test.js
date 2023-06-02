import { module, test } from 'qunit';
import { setupRenderingTest } from 'netrunnerdb/tests/helpers';
import { render } from '@ember/test-helpers';
import { hbs } from 'ember-cli-htmlbars';

module('Integration | Component | card/text-box', function (hooks) {
  setupRenderingTest(hooks);

  test('it renders', async function (assert) {
    // Set any properties with this.set('myProperty', 'value');
    // Handle any actions with this.set('myAction', function(val) { ... });
    this.set('printing', {
      cardTypeId: 'corp_identity',
      minimumDDeckSize: 45,
      influenceLimit: 15,
      cost: 0,
      memoryCost: 0,
      trashCost: 0,
      strength: 0,
      agendaPoints: 0,
    });

    await render(hbs`<Card::TextBox
        @printing={{this.printing}}
        @showThumbnail={{false}}
        @showFlavor={{true}}
        @showProduction={{true}}
      />
    `);

    assert.dom(this.element).exists();
  });
});
