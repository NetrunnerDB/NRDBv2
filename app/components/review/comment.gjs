import Component from '@glimmer/component';
import formatISO8601Date from '../../helpers/format-iso8601-date';

export default class ReviewCommentComponent extends Component {
  constructor(...args) {
    super(...args);
  }

  <template>
    <div class='comment secondary'>
      <div class='comment-content'>
        <div class='user-content'>
          {{@comment.body}}
        </div>
      </div>
      <div class='comment-meta'>
        —
        <span class='anarch'>{{@comment.user}}</span>
        {{formatISO8601Date @comment.created_at}}
      </div>
    </div>
  </template>
}
