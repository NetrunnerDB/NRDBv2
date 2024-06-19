import Component from '@glimmer/component';
import MarkdownToHtml from 'ember-cli-showdown/components/markdown-to-html';
import FaIcon from '@fortawesome/ember-fontawesome/components/fa-icon';
import { FormatDate } from 'netrunnerdb/helpers/format-date';

export default class ReviewCommentComponent extends Component {
  <template>
    <div class='comment secondary'>
      <div class='comment-content'>
        <div class='user-content'>
          Review sucks.
        </div>
      </div>
      <div class='comment-meta'>
        —
        <span class='anarch'>AntiAms</span>
        31 Jul 2022
      </div>
    </div>
  </template>
}
