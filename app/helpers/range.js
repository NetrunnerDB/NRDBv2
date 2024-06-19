import { helper } from '@ember/component/helper';

function range(n) {
  let array = [];
  for (let i = 0; i < n; i++) {
    array.push(i);
  }
  return array;
}

export const Range = range;
export default helper(range);
