import Component from '@glimmer/component';
import { tracked } from '@glimmer/tracking';
import { action } from '@ember/object';
import { fn } from '@ember/helper';
import { on } from '@ember/modifier';
import { eq } from 'netrunnerdb/utils/template-operators';
import sortBy from 'ember-composable-helpers/helpers/sort-by';
import CardLinkTo from './card/link-to';
import InfluencePips from './card/influence-pips';
import FullDisplay from './card/full-display';
import Image from './card/image';
import Stats from './card/stats';
import CardTextBox from './card/text-box';
import Icon from './icon';

export default class CardListsComponent extends Component {
  @tracked display = 'checklist';
  eq = eq;

  constructor() {
    super(...arguments);

    this.display = this.args.display;
  }

  @action setDisplay(display) {
    this.display = display;
  }

  get printingsTableForImages() {
    let t = new Array();

    let numColumns = 4;
    let p = 0;
    let numRows =
      Math.floor(this.args.printings.length / numColumns) +
      (this.args.printings.length % numColumns > 0 ? 1 : 0);
    for (let i = 0; i < numRows; i++) {
      t.push(new Array());
      let row = t[i];
      for (let j = 0; j < numColumns; j++) {
        if (p < this.args.printings.length) {
          row.push(this.args.printings[p]);
          p++;
        }
      }
    }

    return t;
  }

  get printingsTableForTextOnly() {
    let t = new Array();

    let numColumns = 3;
    let p = 0;
    let numRows =
      Math.floor(this.args.printings.length / numColumns) +
      (this.args.printings.length % numColumns > 0 ? 1 : 0);
    for (let i = 0; i < numRows; i++) {
      t.push(new Array());
      let row = t[i];
      for (let j = 0; j < numColumns; j++) {
        if (p < this.args.printings.length) {
          row.push(this.args.printings[p]);
          p++;
        }
      }
    }

    return t;
  }

  <template>
  {{@foo}}
    <div class="card flex-grow-1" id="nav-main-content">
      <div class="card-header">
        <ul class="nav nav-tabs nav-fill card-header-tabs">
          <li class="nav-item">
            <a
              href="#"
              role="button"
              class="nav-link {{if (eq this.display 'checklist') 'active'}}"
              {{on "click" (fn this.setDisplay "checklist")}}
            >Checklist</a>
          </li>
          <li class="nav-item">
            <a
              href="#"
              role="button"
              class="nav-link {{if (eq this.display 'full') 'active'}}"
              {{on "click" (fn this.setDisplay "full")}}
            >Full Cards</a>
          </li>
          <li class="nav-item">
            <a
              href="#"
              role="button"
              class="nav-link {{if (eq this.display 'images') 'active'}}"
              {{on "click" (fn this.setDisplay "images")}}
            >Images Only</a>
          </li>
          <li class="nav-item">
            <a
              href="#"
              role="button"
              class="nav-link {{if (eq this.display 'text') 'active'}}"
              {{on "click" (fn this.setDisplay "text")}}
            >Text Only</a>
          </li>
        </ul>
      </div>

      <div class="card-body">
        {{#if (eq this.display "checklist")}}
          <div id="card-list-checklist">
            <table class="table-striped table-fill">
              <thead>
                <th>Position</th>
                <th>Title</th>
                <th>Faction</th>
                <th>Attributes</th>
                <th>Type: Subtypes</th>
              </thead>
              <tbody>
              {{#each (sortBy "id:asc" @printings) as |printing|}}
                <tr>
                  <td><Icon @icon={{@set.cardCycleId }} />{{ @set.name }} {{ printing.position }}</td>
                  <td>
                      <CardLinkTo @printing={{ printing }}>{{printing.title}}</CardLinkTo>
                  </td>
                  <td><Icon @icon="{{ printing.factionId }}" /><InfluencePips @printing={{ printing }} /></td>
                  <td><Stats @printing={{printing}} /></td>
                  <td><b>{{printing.cardType.name}}</b>{{#if printing.displaySubtypes }}: {{ printing.displaySubtypes }}{{/if}}</td>
                </tr>
              {{/each}}
              </tbody>
            </table>
          </div>

        {{else if (eq this.display "full")}}
          <div id="card-list-full-cards">
            {{#each @printings as |p|}}
              <div class="row">
                <FullDisplay
                    faction={{p.faction}}
                    @cardSet={{p.cardSet}}
                    @cardType={{p.cardType}}
                    @printing={{p}}
                    @showLegality={{false}}
                    @showPrintings={{false}} />
              </div>
            {{/each}}
          </div>

        {{else if (eq this.display "images")}}
          {{#each this.printingsTableForImages as |row|}}
          <div class="row">
            {{#each row as |p|}}
            <div class="col-3 card-art-container px-3 pb-1 p-sm-0">
              <Image src={{p.images.nrdb_classic.large}} />
            </div>
            {{/each}}
          </div>
          {{/each}}

        {{else if (eq this.display "text")}}
          <div id="card-list-text-only">
            {{#each this.printingsTableForTextOnly as |row|}}
              <div class="row">
                {{#each row as |p|}}
                  <div class="col-4">
                    <CardTextBox
                        @cardSet={{@p.cardSet}}
                        @cardType={{@p.cardType}}
                        @faction={{@p.faction}}
                        @printing={{p}}
                        @showIllustrators={{true}}
                        @showThumbnail={{false}}
                        @showFlavor={{true}}
                        @showProduction={{true}}
                    />
                  </div>
                {{/each}}
              </div>
            {{/each}}
          </div>
        {{/if}}
      </div>
    </div>
  </template>
}
