export const eq = (a, b) => a === b;
export const maybe = (val, def = 'X') => (val ? val : def);
export const formatDate = (date) => Intl.DateTimeFormat().format(date);
