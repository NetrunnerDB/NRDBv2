import Component from '@glimmer/component';
import Icon from './icon';
import MarkdownToHtml from 'ember-cli-showdown/components/markdown-to-html';
import { FormatDate } from 'netrunnerdb/helpers/format-date';

export default class RulingComponent extends Component {
  <template>
    <div class='ruling'>
      <div class='ruling-header'>
        {{#if @ruling.nsgRulesTeamVerified}}
          <span class='legality-verified'></span>
        {{else}}
          <span class='legality-unverified'></span>
        {{/if}}
        <span class='fst-italic ms-1 font-size-14'>
          Updated
          {{FormatDate @ruling.updatedAt}}
        </span>
      </div>
      {{#if @ruling.question}}
        <div class='ruling-question'>
          <MarkdownToHtml @markdown={{@ruling.question}} />
        </div>
        <div class='ruling-answer mt-2'>
          <MarkdownToHtml @markdown={{@ruling.answer}} />
        </div>
      {{else}}
        <div class='ruling-text'>
          <MarkdownToHtml @markdown={{@ruling.textRuling}} />
        </div>
      {{/if}}
    </div>
  </template>
}
