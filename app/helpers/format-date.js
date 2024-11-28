import { helper } from '@ember/component/helper';

export function formatDate(date) {
  return new Intl.DateTimeFormat().format(new Date(date)).replaceAll('/', '-');
}

export default helper(formatDate);
