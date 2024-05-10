import { helper } from '@ember/component/helper';

function splitIdentityName(idName) {
  if (!idName) {
    return;
  }
  let split = idName.split(': ');
  return {
    title: split[0],
    subtitle: split[1],
  };
}

function getIdentityTitle(idName) {
  if (!idName) {
    return;
  }
  return idName.split(': ')[0];
}

function getIdentitySubtitle(idName) {
  if (!idName) {
    return;
  }
  return idName.split(': ')[1];
}

export const SplitIdentityName = splitIdentityName;
export const GetIdentityTitle = getIdentityTitle;
export const GetIdentitySubtitle = getIdentitySubtitle;
export default helper(splitIdentityName);
