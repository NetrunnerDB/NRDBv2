import { helper } from '@ember/component/helper';

function truncateType(typeName) {
  if (typeName == 'Corp Identity' || typeName == 'Runner Identity') {
    return 'Identity';
  }
  if (typeName == 'corp_identity' || typeName == 'runner_identity') {
    return 'identity';
  }
  return typeName;
}

export const TruncateType = truncateType;
export default helper(truncateType);
