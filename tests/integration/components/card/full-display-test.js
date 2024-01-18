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
      snapshotIds: [],
      restrictions: {
        banned: [],
        global_penalty: [],
        points: {},
        restricted: [],
        universal_faction_cost: {},
      },
      images: [],
      designedBy: 'null_signal_games',
      releasedBy: 'null_signal_games',
    });
    this.set('snapshot', {
      id: 'snapshot',
      restrictionId: 'restriction',
    });

    await render(
      hbs`<Card::FullDisplay @printing={{this.printing}} @standardSnapshot={{this.snapshot}} @eternalSnapshot={{this.snapshot}} @startupSnapshot={{this.snapshot}} />`,
    );

    assert.dom(this.element).exists();
  });
});
