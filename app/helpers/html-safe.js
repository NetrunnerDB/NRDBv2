import { helper } from '@ember/component/helper';
import { htmlSafe as markAsSafe } from '@ember/template';

export default helper(function htmlSafe([content] /*, named*/) {
  return markAsSafe(content);
});
