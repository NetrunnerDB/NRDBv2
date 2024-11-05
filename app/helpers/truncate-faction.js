import { helper } from '@ember/component/helper';

function truncateFaction(factionName) {
  if (factionName == 'Weyland Consortium') {
    return 'Weyland';
  }
  if (factionName == 'Neutral Corp' || factionName == 'Neutral Runner') {
    return 'Neutral';
  }
  return factionName;
}

export const TruncateFaction = truncateFaction;
export default helper(truncateFaction);
