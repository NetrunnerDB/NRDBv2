import { helper } from '@ember/component/helper';

export function formatIso8601Date(date) {
  // Force to a locale with an ISO8601 format.
  return new Intl.DateTimeFormat('en-CA').format(new Date(date));
}

export default helper(formatIso8601Date);
