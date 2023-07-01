import Route from '@ember/routing/route';
import { service } from '@ember/service';

export default class PageFormatsRoute extends Route {
  @service store;

  async model() {
    // Get all formats
    let formats = await this.store.findAll('format');

    // Get the major formats
    let [standard, startup, eternal] = await Promise.all([
      this.store.findRecord('format', 'standard'),
      this.store.findRecord('format', 'startup'),
      this.store.findRecord('format', 'eternal'),
    ]);

    // Get their current snapshot
    let [sStandard, sStartup, sEternal] = await Promise.all([
      this.store.findRecord('snapshot', standard.activeSnapshotId),
      this.store.findRecord('snapshot', startup.activeSnapshotId),
      this.store.findRecord('snapshot', eternal.activeSnapshotId),
    ]);

    return {
      formats: formats,
      standard: {
        format: standard,
        snapshot: sStandard,
      },
      startup: {
        format: startup,
        snapshot: sStartup,
      },
      eternal: {
        format: eternal,
        snapshot: sEternal,
      },
    };
  }
}
