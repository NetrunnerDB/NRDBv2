import Component from '@glimmer/component';
import { action } from '@ember/object';
import { service } from '@ember/service';
import { tracked } from '@glimmer/tracking';
import BsForm from 'ember-bootstrap/components/bs-form';
import PowerSelect from 'ember-power-select/components/power-select';

export default class SearchFormComponent extends Component {
  @service router;

  @tracked _display;
  @tracked _max_records;
  @tracked _query;

  get query() {
    return this._query ? this._query : this.args.query;
  }
  @action setQuery(f) {
    this._query = f;
  }
  get max_records() {
    return this._max_records ? this._max_records : this.args.max_records;
  }
  @action setMaxRecords(f) {
    this._max_records = f.id;
  }
  get display() {
    return this._display ? this._display : this.args.display;
  }
  @action setDisplay(f) {
    this._display = f.id;
  }

  get selectedMaxRecords() {
    return this.single(this.max_records, this.maxRecords);
  }
  get selectedDisplay() {
    return this.single(this.display, this.displayOptions);
  }

  // Provide value for single select element.
  single(param, objects) {
    if (!param) {
      return null;
    }
    let id = String(param).toLowerCase();
    let matches = objects.filter((x) => x.id == id);
    if (matches.length > 0) {
      return matches[0];
    }
    return null;
  }

  displayOptions = [
    { id: 'checklist', name: 'Checklist' },
    { id: 'full', name: 'Full Card' },
    { id: 'images', name: 'Image Only' },
    { id: 'text', name: 'Text Only' },
  ];
  maxRecords = [25, 50, 100, 250, 500, 1000, 5000].map((x) => {
    return { id: x, name: x };
  });

  @action doSearch() {
    this.router.transitionTo(this.router.currentRouteName, {
      queryParams: {
        query: this.query,
        display: this.display,
        max_records: this.max_records,
      },
    });
  }

  <template>
    <h1>Basic Search Form</h1>

    <BsForm @formLayout="vertical" @onSubmit={{this.doSearch}} as |form|>
      <fieldset>
        <div class="row">
          <div class="col-sm-12">
            <form.element
              @controlType="textarea"
              @label="Query"
              @value={{this.query}}
              @onChange={{this.setQuery}}
            />
          </div>
        </div>
      </fieldset>

      <div class="row">
        <div class="col-sm-3">
          <form.element @label="Num Records" @property="max_records" as |el|>
            <PowerSelect
              @options={{this.maxRecords}}
              @selected={{this.selectedMaxRecords}}
              @triggerId={{el.id}}
              {{!-- @onFocus={{action.focus}} --}}
              @onChange={{this.setMaxRecords}}
              as |x|
            >
              {{x.name}}
            </PowerSelect>
          </form.element>
        </div>
        <div class="col-sm-3">
          <form.element @label="Display" @property="display" as |el|>
            <PowerSelect
              @options={{this.displayOptions}}
              @selected={{this.selectedDisplay}}
              @triggerId={{el.id}}
              {{!-- @onFocus={{action.focus}} --}}
              @onChange={{this.setDisplay}}
              as |x|
            >
              View as
              {{x.name}}
            </PowerSelect>
          </form.element>
        </div>
      </div>
      <div class="row">
        <div class="col-sm-2">
          <form.submitButton>Submit</form.submitButton>
        </div>
      </div>
    </BsForm>
  </template>
}
