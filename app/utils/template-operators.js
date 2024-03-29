export const and = (a, b) => a && b;
export const eq = (a, b) => a === b;
export const maybe = (val, def = 'X') => {
  return val !== null && val != -1 ? val : def;
};
export const formatDate = (date) => Intl.DateTimeFormat().format(date);
export const replaceClassCardPageUrls = (t) =>
  t.replaceAll(/\/en\/card\//g, '/page/card/');
