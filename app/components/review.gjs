import Component from '@glimmer/component';
import { service } from '@ember/service';
import FaIcon from '@fortawesome/ember-fontawesome/components/fa-icon';
import CardImage from 'netrunnerdb/components/card/image';
import Comment from 'netrunnerdb/components/review/comment';

export default class ReviewComponent extends Component {
  @service store;

  constructor(...args) {
    super(...args);

    this.printing = this.store.findRecord('printing', '26026');
  }

  <template>
    <div class='review'>
      <div class='review-buttons'>
        <div class='likes'><FaIcon @icon='heart' /> 19</div>
        <div class='comments mt-2'><FaIcon @icon='message' /> 3</div>
      </div>
      <div class='review-main'>
        <div class='review-header font-size-18'>
          <div class='d-flex justify-content-between'>
            <div>
              A review by
              <span class='shaper'>Ams</span>
              <span class='font-size-14'>69</span>
              - 12 Jan 2017 (Quorum era)
            </div>
            <div>
              Rezeki
            </div>
          </div>
        </div>
        <div class='review-content'>
          {{#if @showPrinting}}
            <div class='float-end col-2 ms-2 my-2'>
              <CardImage src='{{this.printing.images.nrdb_classic.large}}' />
            </div>
          {{/if}}
          <div class='user-content'>
            <p>
              Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aliquam
              dictum, nulla in tempus gravida, magna justo scelerisque massa, et
              tempus diam ligula nec neque. Mauris a nibh non nisl fermentum
              tempus. Aenean quis diam est. Sed varius est vitae interdum
              fermentum. Etiam bibendum tincidunt sem, eu porta leo egestas vel.
              Interdum et malesuada fames ac ante ipsum primis in faucibus.
              Phasellus scelerisque, orci a aliquam fringilla, est augue
              lobortis libero, et lacinia quam erat in enim. Nunc accumsan, elit
              eget sollicitudin pellentesque, dolor risus finibus ex, sed semper
              ex diam nec diam.
            </p>
            <p>
              Morbi eget est accumsan, eleifend nisi vel, convallis diam. Nulla
              facilisi. Nunc imperdiet magna vehicula nunc vehicula congue eget
              quis quam. Duis quis gravida sapien. Aliquam porttitor feugiat mi.
              Curabitur at lorem et neque cursus sagittis commodo eget nunc. Sed
              porttitor ante vitae purus ultricies tempus. Nunc maximus vitae
              lorem eu vehicula. Nunc gravida sed urna nec dapibus. Etiam sed
              nunc id diam ullamcorper sagittis. Sed interdum faucibus mi, at
              venenatis quam egestas vitae. Nunc pharetra ligula at mollis
              auctor. Nunc nisl risus, placerat a massa nec, congue faucibus
              enim. Sed consequat sapien imperdiet condimentum dapibus.
              Phasellus finibus turpis in justo lacinia, id tincidunt velit
              porta. Aenean et accumsan sem.
            </p>
            <p>
              Donec dignissim mattis rhoncus. Fusce accumsan hendrerit nisi quis
              sagittis. Cras urna magna, iaculis eu fermentum et, venenatis quis
              risus. Sed euismod, est et molestie interdum, odio purus ultricies
              urna, nec molestie lectus magna vel felis. Cras porttitor
              convallis orci vel tempus. Pellentesque pretium, neque ut sodales
              mattis, ante orci tempus risus, vitae luctus ex lorem ac neque.
              Nunc quis convallis nunc, ac scelerisque nunc. Cras blandit odio
              nibh, non mattis nunc consequat vitae. Sed non urna sed ante
              auctor pulvinar. Donec metus neque, malesuada sit amet volutpat
              at, malesuada sed metus. In orci magna, tempus id orci et,
              fringilla viverra diam.
            </p>
            <p>
              Aliquam sollicitudin lobortis lectus, eleifend luctus velit
              ultrices ac. Morbi imperdiet augue sit amet turpis molestie, ut
              faucibus metus vestibulum. Duis tempor at mi pharetra pretium.
              Nullam ac sollicitudin sapien. Phasellus mauris eros, egestas ac
              egestas in, aliquet et libero. Praesent commodo arcu quis nisi
              placerat pellentesque. Vivamus imperdiet felis ac ipsum maximus
              fermentum non vel nulla. Morbi posuere, massa non finibus dictum,
              tellus massa fringilla mauris, ac vestibulum risus erat nec risus.
              Fusce vel imperdiet ligula. Nullam sapien diam, facilisis vehicula
              hendrerit nec, finibus at mauris. In vitae eros in velit dictum
              commodo vitae feugiat felis. Donec tristique elit in mi rutrum, id
              auctor tortor volutpat.
            </p>
            <p>
              Nunc id feugiat lectus, eu interdum purus. Proin et sodales
              mauris, sit amet gravida turpis. Integer quis dui vitae orci
              euismod fringilla. Pellentesque tempor molestie suscipit. In hac
              habitasse platea dictumst. Vestibulum sed laoreet orci, ac
              hendrerit velit. Sed risus mi, auctor a elementum eget, mattis in
              mauris. Ut ac lectus urna. Nulla at gravida lorem. Etiam velit
              enim, fermentum ac tempus eget, interdum quis lacus. Sed quam
              ligula, rhoncus sit amet ex eu, venenatis tempus magna. Maecenas
              sit amet elementum arcu.
            </p>
          </div>
        </div>
        <div class='review-comments'>
          <div>
            <Comment />
          </div>
          <div>
            <Comment />
          </div>
          <div>
            <Comment />
          </div>
        </div>
      </div>
    </div>
  </template>
}
