import { helper } from '@ember/component/helper';

export default helper(function hyphenate([input]) {
  return input.replace(/_/g, '-'); // Replace all underscores with dashes
});
