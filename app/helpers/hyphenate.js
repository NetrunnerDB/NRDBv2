import { helper } from '@ember/component/helper';

function hyphenate(input) {
  if (!input || !input.replace) {
    return;
  }
  return input.replace(/[ _]/g, '-'); // Replace all whitespace and underscores with dashes
}

export const Hyphenate = hyphenate;
export default helper(hyphenate);
