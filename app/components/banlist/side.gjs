import Points from './points';
import Banned from './banned';
import CardLinkTo from '../card/link-to';
import { get } from '@ember/helper';
import Component from '@glimmer/component';

// TODO(locks): replace style hack with a CSS class
const capitalize = 'text-transform: capitalize';

export default class Side extends Component {
  get currentFormat() {
    return this.args.formats?.find((f) => f.id === this.args.selectedFormat);
  }

  get hasBanned() {
    return this.args.restriction.obj.verdicts.banned.length;
  }

  get hasPoints() {
    return Object.keys(this.args.restriction.obj.verdicts.points).length > 0;
  }

  <template>
    <div class='col-6'>
      <h3 style={{capitalize}}>{{@side}} Cards</h3>

      {{#if this.hasBanned}}
        <Banned
          @restriction={{@restriction.obj}}
          @side={{@side}}
          @cards={{@cards}}
        />
      {{/if}}

      {{#if @restriction.obj.verdicts.restricted.length}}
        <ul>
          <li>
            <strong>Restricted</strong>
            <ul>
              {{#each (get @restriction @side 'restricted') as |restricted|}}
                <li>
                  <CardLinkTo @printing={{restricted}} class='text-truncate'>
                    {{restricted.title}}
                  </CardLinkTo>
                </li>
              {{/each}}
            </ul>
          </li>
        </ul>
      {{/if}}

      {{#if @restriction.obj.verdicts.global_penalty.length}}
        <ul>
          <li>
            <strong>Global Penalty</strong>
            <ul>
              {{#each
                (get (get @restriction @side) 'global_penalty')
                as |global_penalty|
              }}
                <li>
                  <CardLinkTo
                    @printing={{global_penalty}}
                    class='text-truncate'
                  >
                    {{global_penalty.title}}
                  </CardLinkTo>
                </li>
              {{/each}}
            </ul>
          </li>
        </ul>
      {{/if}}

      {{#if this.hasPoints}}
        <Points
          @currentFormat={{this.currentFormat}}
          @restriction={{@restriction.obj}}
          @side={{@side}}
        />
      {{/if}}

      {{#if @restriction.hasUniversalInfluence}}
        <ul>
          <li>
            <strong>Universal Influence</strong>
            <ul>
              {{#let
                (get (get @restriction @side) 'threeUniversalInfluence')
                as |threeInf|
              }}
                {{#if threeInf.length}}
                  <li>
                    <strong>3 Influence</strong>
                    <ul>
                      {{#each threeInf as |card|}}
                        <li>
                          <CardLinkTo @printing={{card}} class='text-truncate'>
                            {{card.title}}
                          </CardLinkTo>
                        </li>
                      {{/each}}
                    </ul>
                  </li>
                {{/if}}
              {{/let}}
              {{#let
                (get (get @restriction @side) 'oneUniversalInfluence')
                as |oneInf|
              }}
                {{#if oneInf.length}}
                  <li>
                    <strong>1 Universal Influence</strong>
                    <ul>
                      {{#each oneInf as |card|}}
                        <li>
                          <CardLinkTo @printing={{card}} class='text-truncate'>
                            {{card.title}}
                          </CardLinkTo>
                        </li>
                      {{/each}}
                    </ul>
                  </li>
                {{/if}}
              {{/let}}
            </ul>
          </li>
        </ul>
      {{/if}}

    </div>
  </template>
}
