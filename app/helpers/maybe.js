import { helper } from '@ember/component/helper';

function maybe(val) {
  return val !== null && val != -1 ? val : 'X';
}

export const Maybe = maybe;
export default helper(maybe);
