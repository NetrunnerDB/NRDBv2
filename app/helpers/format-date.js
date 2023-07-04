import { helper } from '@ember/component/helper';

export default helper(function formatDate([date] /*, named*/) {
  return Intl.DateTimeFormat().format(date);
});
