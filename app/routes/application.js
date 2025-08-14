import Route from '@ember/routing/route';
import { service } from '@ember/service';

export default class ApplicationRoute extends Route {
  @service session;
  @service intl;
  @service('all-printings') allPrintings;

  queryParams = {
    refreshCache: { refreshModel: false }
  };

  async beforeModel() {
    await this.session.setup();
    this.intl.setLocale(['pt-PT', 'en-US']);
  }

  activate() {
    // Check if cache refresh is requested via query parameter
    const params = this.paramsFor('application');
    const forceRefresh = params.refreshCache === 'true';
    
    this.allPrintings.loadPrintings(forceRefresh);
  }
}
