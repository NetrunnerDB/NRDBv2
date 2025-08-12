import Component from '@glimmer/component';
import { tracked } from '@glimmer/tracking';
import { hash } from '@ember/helper';
import { service } from '@ember/service';
import { eq } from 'netrunnerdb/utils/template-operators';
import { LinkTo } from '@ember/routing';
import { sortBy } from '@nullvoxpopuli/ember-composable-helpers';
import CardLinkTo from './card/link-to';
import InfluencePips from './card/influence-pips';
import FullDisplay from './card/full-display';
import Image from './card/image';
import Stats from './card/stats';
import CardTextBox from './card/text-box';
import Icon from './icon';

export default class CardListsComponent extends Component {
  @service router;
  @tracked display = 'checklist';

  makeNColumnTable(printings, numColumns) {
    let t = new Array();

    let p = 0;
    let numRows =
      Math.floor(printings.length / numColumns) +
      (printings.length % numColumns > 0 ? 1 : 0);
    for (let i = 0; i < numRows; i++) {
      t.push(new Array());
      let row = t[i];
      for (let j = 0; j < numColumns; j++) {
        if (p < printings.length) {
          row.push(printings[p]);
          p++;
        }
      }
    }

    return t;
  }

  get printingsTableForImages() {
    return this.makeNColumnTable(this.args.printings, 4);
  }

  get printingsTableForTextOnly() {
    return this.makeNColumnTable(this.args.printings, 3);
  }

  <template>
    <div class="card flex-grow-1" id="nav-main-content">
      <div class="card-header">
        <ul class="nav nav-tabs nav-fill card-header-tabs">
          <li class="nav-item">
            <LinkTo
              @query={{hash display="checklist"}}
              role="button"
              class="nav-link"
            >Checklist</LinkTo>
          </li>
          <li class="nav-item">
            <LinkTo
              @query={{hash display="full"}}
              role="button"
              class="nav-link"
            >Full Cards</LinkTo>
          </li>
          <li class="nav-item">
            <LinkTo
              @query={{hash display="images"}}
              role="button"
              class="nav-link"
            >Images Only</LinkTo>
          </li>
          <li class="nav-item">
            <LinkTo
              @query={{hash display="text"}}
              role="button"
              class="nav-link"
            >Text Only</LinkTo>
          </li>
        </ul>
      </div>

      <div class="card-body">
        {{#if (eq @display "checklist")}}
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
                    <td><Icon
                        @icon={{printing.cardCycleId}}
                      />{{printing.cardSet.name}}
                      {{printing.position}}</td>
                    <td>
                      <CardLinkTo @printing={{printing}}>{{#if
                          printing.isUnique
                        }}♦ {{/if}}{{printing.title}}</CardLinkTo>
                    </td>
                    <td><Icon @icon="{{printing.factionId}}" /><InfluencePips
                        @printing={{printing}}
                      /></td>
                    <td><Stats @printing={{printing}} /></td>
                    <td><b>{{printing.cardType.name}}</b>{{#if
                        printing.displaySubtypes
                      }}: {{printing.displaySubtypes}}{{/if}}</td>
                  </tr>
                {{/each}}
              </tbody>
            </table>
          </div>

        {{else if (eq @display "full")}}
          <div id="card-list-full-cards">
            {{#each @printings as |p|}}
              <div class="row">
                <FullDisplay
                  faction={{p.faction}}
                  @cardSet={{p.cardSet}}
                  @cardType={{p.cardType}}
                  @printing={{p}}
                  @showLegality={{false}}
                  @showPrintings={{false}}
                />
              </div>
            {{/each}}
          </div>

        {{else if (eq @display "images")}}
          {{#each this.printingsTableForImages as |row|}}
            <div class="row">
              {{#each row as |p|}}
                <div
                  class="col-xl-3 col-lg-3 col-md-6 card-art-container px-2 pb-3"
                >
                  <CardLinkTo @printing={{p}}><Image
                      src={{p.images.nrdb_classic.large}}
                    /></CardLinkTo>
                </div>
              {{/each}}
            </div>
          {{/each}}

        {{else if (eq @display "text")}}
          <div id="card-list-text-only">
            {{#each this.printingsTableForTextOnly as |row|}}
              <div class="row">
                {{#each row as |p|}}
                  <div class="card col-4 px-md-0">
                    <div class="card-header">
                      <div class="card-title">
                        <CardLinkTo @printing={{p}}>{{#if p.isUnique}}♦
                          {{/if}}{{p.title}}</CardLinkTo>
                      </div>
                    </div>
                    <div class="card-body">
                      <CardTextBox
                        @cardSet={{@p.cardSet}}
                        @cardType={{@p.cardType}}
                        @faction={{@p.faction}}
                        @printing={{p}}
                        @showIllustrators={{true}}
                        @showThumbnail={{false}}
                        @showFlavor={{true}}
                        @showProduction={{false}}
                      />
                    </div>
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
