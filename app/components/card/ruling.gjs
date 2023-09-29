import Component from '@glimmer/component';
import MarkdownIt from 'markdown-it';
import { replaceClassCardPageUrls } from 'netrunnerdb/utils/template-operators';
import { htmlSafe } from '@ember/template';

export default class CardRulingComponent extends Component {
  md = new MarkdownIt();

  get verifiedClass() {
    return this.args.ruling.nsgRulesTeamVerified
      ? 'legality-verified'
      : 'legality-unverified';
  }

  get textRuling() {
    return htmlSafe(
      this.md.render(replaceClassCardPageUrls(this.args.ruling.textRuling)),
    );
  }

  get question() {
    return htmlSafe(
      this.md.render(replaceClassCardPageUrls(this.args.ruling.question)),
    );
  }

  get answer() {
    return htmlSafe(
      this.md.render(replaceClassCardPageUrls(this.args.ruling.answer)),
    );
  }

  <template>
    <div id="ruling-{{@ruling.id}}">
      <p class="{{ this.verifiedClass }}"> {{ @ruling.updatedAt }}</p>
      {{#if @ruling.textRuling}}
      <p>Text Ruling: {{ this.textRuling }}</p>
      {{else}}
      <p>Question: {{ this.question }}</p>
      <p>Answer: {{ this.answer }}</p>
      {{/if}}
    </div>
    <hr />
  </template>
}
