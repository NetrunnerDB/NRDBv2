import Component from '@glimmer/component';
import { action } from '@ember/object';
import { service } from '@ember/service';
import { fn } from '@ember/helper';
import { tracked } from '@glimmer/tracking';
import BsForm from 'ember-bootstrap/components/bs-form';
import PowerSelect from 'ember-power-select/components/power-select';

export default class SearchFormComponent extends Component {
  @service router;
  @tracked searchParams;

  // TODO(plural): sort params to aid caching.
  constructor() {
    super(...arguments);
    this.searchParams = this.args.searchParams;
    let p = this.searchParams;
    let a = this.args.searchParams;

    p.display = this.single(a.display, this.displayOptions);
    p.max_records = this.single(a.max_records, this.maxRecords);
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

  // Provide values for multi-select element.
  multi(param, objects) {
    if (!param) {
      return [];
    }
    let ids = param.toLowerCase().split?.(',');
    return objects.filter((x) => ids.includes(x.id));
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

  getText(p, q, field) {
    if (p[field] && p[field].trim().length > 0) {
      q[field] = p[field].trim();
    } else {
      q[field] = null;
    }
  }
  getSelect(p, q, field) {
    if (p[field]) {
      q[field] = p[field].id;
    } else {
      q[field] = null;
    }
  }

  getMultiSelect(p, q, field) {
    if (p[field] && p[field].length != 0) {
      q[field] = p[field].map((x) => x.id);
    } else {
      q[field] = null;
    }
  }

  @action doSearch() {
    let p = this.searchParams;
    let q = {};

    this.getSelect(p, q, 'display');
    this.getSelect(p, q, 'max_records');
    this.getText(p, q, 'query');

    this.router.transitionTo(this.router.currentRouteName, {
      queryParams: q,
    });
  }

  <template>
    <h1>Basic Search Form</h1>

    <BsForm
      @formLayout='vertical'
      @onSubmit={{this.doSearch}}
      @model={{this.searchParams}}
      as |form|
    >
      <fieldset>
        <div class='row'>
          <div class='col-sm-12'>
            <form.element
              @controlType='textarea'
              @label='Query'
              @property='query'
            />
          </div>
        </div>
      </fieldset>

      <div class='row'>
        <div class='col-sm-3'>
          <form.element @label='Num Records' @property='max_records' as |el|>
            <PowerSelect
              @options={{this.maxRecords}}
              @selected={{this.searchParams.max_records}}
              @triggerId={{el.id}}
              @onFocus={{action.focus}}
              @onChange={{fn (mut this.searchParams.max_records)}}
              as |x|
            >
              {{x.name}}
            </PowerSelect>
          </form.element>
        </div>
        <div class='col-sm-3'>
          <form.element @label='Display' @property='display' as |el|>
            <PowerSelect
              @options={{this.displayOptions}}
              @selected={{this.searchParams.display}}
              @triggerId={{el.id}}
              @onFocus={{action.focus}}
              @onChange={{fn (mut this.searchParams.display)}}
              as |x|
            >
              View as
              {{x.name}}
            </PowerSelect>
          </form.element>
        </div>
      </div>
      <div class='row'>
        <div class='col-sm-2'>
          <form.submitButton>Submit</form.submitButton>
        </div>
      </div>
    </BsForm>
  </template>
}
