export const and = (a, b) => a && b;
export const or = (a, b) => a || b;
export const eq = (a, b) => a === b;
export const ne = (a, b) => a !== b;
export const div = (a, b) => a / b;
export const mul = (a, b) => a * b;
export const add = (a, b) => a + b;
export const sub = (a, b) => a - b;
export const maybe = (val, def = 'X') => {
  return val !== null && val != -1 ? val : def;
};
export const replaceClassCardPageUrls = (t) =>
  t.replaceAll(/\/en\/card\//g, '/page/card/');
