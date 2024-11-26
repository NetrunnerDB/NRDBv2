import { helper } from '@ember/component/helper';

export function formatDate(date) {
  // TODO: Use real user locale and sync to language.
  return new Intl.DateTimeFormat('fr-CA')
    .format(new Date(date))
    .replaceAll('/', '-');
}

export default helper(formatDate);
