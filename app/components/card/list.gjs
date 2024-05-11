import Component from '@glimmer/component';
import truncateType from 'netrunnerdb/helpers/truncate-type';
import {
  eq,
  notEq,
  not,
  or,
  notEmpty,
  maybe,
} from 'netrunnerdb/utils/template-operators';
import Icon from '../icon';
import InfluencePips from './influence-pips';
import LinkTo from './link-to';

export default class CardListComponent extends Component {
  <template>
    <table class='results mt-4'>
      <thead>
        <tr>
          <th>Qty.</th>
          <th>Name</th>
          <th>Influence</th>
          <th>Faction</th>
          <th>Type</th>
          <th>Subtype</th>
          <th>Cost</th>
          <th>...</th>
          <th>Strength</th>
        </tr>
      </thead>
      <tbody>
        {{#each @printings as |printing|}}
          <tr>
            <td>
              <span class='badge {{if (notEq printing.quantity 3) "anarch"}}'>
                {{printing.quantity}}
              </span>
            </td>
            <td>
              <LinkTo @printing={{printing}} class='text-truncate'>
                {{printing.title}}
              </LinkTo>
            </td>
            <td>
              {{#if (notEmpty printing.influenceCost)}}
                {{printing.influenceCost}}
                <InfluencePips
                  @factionId={{printing.factionId}}
                  @count={{printing.influenceCost}}
                />
              {{/if}}
            </td>
            <td><Icon @icon={{printing.factionId}} /></td>
            <td>
              <Icon @icon={{truncateType printing.cardTypeId}} />
              {{truncateType printing.cardType.name}}
            </td>
            <td>{{printing.displaySubtypes}}</td>
            <td>
              {{#if (notEmpty printing.cost)}}
                {{maybe printing.cost}}
                {{#if
                  (or
                    (eq printing.sideId 'runner')
                    (eq printing.typeId 'operation')
                  )
                }}
                  <Icon @icon='credit' />
                {{else}}
                  <Icon @icon='rez-cost' />
                {{/if}}
              {{else if (notEmpty printing.advancementRequirement)}}
                {{maybe printing.advancementRequirement}}
                <Icon @icon='agenda-points-simple' />
              {{else if (notEmpty printing.minimumDeckSize)}}
                {{printing.minimumDeckSize}}
              {{/if}}
            </td>
            <td>
              {{#if (notEmpty printing.trashCost)}}
                {{maybe printing.trashCost}}
                <Icon @icon='trash-cost' />
              {{else if (notEmpty printing.agendaPoints)}}
                {{printing.agendaPoints}}
              {{else if (notEmpty printing.influenceLimit)}}
                {{printing.influenceLimit}}
              {{/if}}
            </td>
            <td>
              {{#if (notEmpty printing.strength)}}
                {{maybe printing.strength}}
                <Icon @icon='strength' />
              {{/if}}
            </td>
          </tr>
        {{/each}}
      </tbody>
    </table>
  </template>
}
