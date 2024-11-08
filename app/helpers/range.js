import { helper } from '@ember/component/helper';

function range(n) {
  return Array(n);
}

export const Range = range;
export default helper(range);
