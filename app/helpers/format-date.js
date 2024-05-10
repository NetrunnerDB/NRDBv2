import { helper } from '@ember/component/helper';

function formatDate(date) {
  return new Intl.DateTimeFormat('en-GB')
    .format(new Date(date))
    .replaceAll('/', '-');
}

export const FormatDate = formatDate;
export default helper(formatDate);
