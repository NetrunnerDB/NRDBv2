import Controller from '@ember/controller';
import { tracked } from '@glimmer/tracking';

export default class AdvancedSearchController extends Controller {
  queryParams = ['display', 'query'];

  @tracked display = 'checklist';
  @tracked query = '';

  @tracked additional_cost = null;
  @tracked advanceable = null;
  @tracked advancement_cost = null;
  @tracked agenda_points = null;
  @tracked attribution = null;
  @tracked base_link = null;
  @tracked card_cycle = null;
  @tracked card_pool = null;
  @tracked card_set = null;
  @tracked card_subtype_id = null;
  @tracked card_type_id = null;
  @tracked cost = null;
  @tracked designed_by = null;
  @tracked faction_id = null;
  @tracked flavor = null;
  @tracked format = null;
  @tracked gains_subroutines = null;
  @tracked illustrator_id = null;
  @tracked influence_cost = null;
  @tracked interrupt = null;
  @tracked is_unique = null;
  @tracked latest_printing_only = null;
  @tracked link_provided = null;
  @tracked max_records = null;
  @tracked memory_usage = null;
  @tracked mu_provided = null;
  @tracked num_printed_subroutines = null;
  @tracked num_printings = null;
  @tracked num_records = null;
  @tracked on_encounter_effect = null;
  @tracked performs_trace = null;
  @tracked position = null;
  @tracked quantity = null;
  @tracked recurring_credits_provided = null;
  @tracked release_date = null;
  @tracked released_by = null;
  @tracked restriction_id = null;
  @tracked rez_effect = null;
  @tracked side_id = null;
  @tracked snapshot = null;
  @tracked strength = null;
  @tracked text = null;
  @tracked title = null;
  @tracked trash_ability = null;
  @tracked trash_cost = null;
}
