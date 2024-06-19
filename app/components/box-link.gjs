import Component from '@glimmer/component';
import { tracked } from '@glimmer/tracking';
import { LinkTo } from '@ember/routing';
import { service } from '@ember/service';
import Icon from './icon';

export default class CardListsComponent extends Component {
  @service store;
  @tracked latestSet;

  constructor(...args) {
    super(...args);

    this.latestSet = this.store.query('cardSet', {});
  }

  <template>
    <LinkTo
      @route='set'
      @model='rebellion_without_rehearsal'
      class='box-link latest-set'
    >
      <div class='row'>
        <div class='col-2 col-lg-4'>
          <img
            src='/assets/image/set/liberation.png'
            alt='Liberation cycle icon'
            style='width:100%; opacity:50%;'
          />
        </div>
        <div class='col-10 col-lg-8 position-relative'>
          <div
            class='position-absolute w-75'
            style='top:50%; transform:translateY(-50%)'
          >
            <div>
              Latest set:
            </div>
            <div class='fst-italic'>
              Rebellion without Rehearsal
            </div>
          </div>
        </div>
      </div>
    </LinkTo>
  </template>
}
