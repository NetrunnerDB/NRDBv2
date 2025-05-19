import Component from '@glimmer/component';
import { service } from '@ember/service';
import FaIcon from '@fortawesome/ember-fontawesome/components/fa-icon';
import { faHeart, faMessage } from '@fortawesome/free-solid-svg-icons';
import CardImage from 'netrunnerdb/components/card/image';
import Comment from 'netrunnerdb/components/review/comment';
import formatISO8601Date from '../helpers/format-iso8601-date';

export default class ReviewComponent extends Component {
  @service store;

  constructor(...args) {
    super(...args);
  }

  <template>
    <div class='review'>
      <div class='review-buttons'>
        <div class='likes'><FaIcon @icon={{faHeart}} /> {{@review.votes}}</div>
        <div class='comments mt-2'><FaIcon @icon={{faMessage}} />
          {{@review.comments.length}}
        </div>
      </div>
      <div class='review-main'>
        <div class='review-header font-size-18'>
          <div class='d-flex justify-content-between'>
            <div>
              A review by
              {{@review.username}}
              -
              {{formatISO8601Date @review.createdAt}}
            </div>
            {{#if @showCard}}
              <div>
                {{@card.title}}
              </div>
            {{/if}}
          </div>
        </div>
        <div class='review-content'>
          {{#if @showPrinting}}
            <div class='float-end col-2 ms-2 my-2'>
              <CardImage src='{{@printing.images.nrdb_classic.large}}' />
            </div>
          {{/if}}
          <div class='user-content'>
            <p>{{@review.body}}</p>
          </div>
        </div>

        <div class='review-comments'>
          {{#each @review.comments as |comment|}}
            <Comment @comment={{comment}} />
          {{/each}}
        </div>
      </div>
    </div>
  </template>
}
