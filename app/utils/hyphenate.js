export default function hyphenate(input) {
  if (!input || !input.replace) {
    return;
  }
  return input.replace(/[ _]/g, '-'); // Replace all whitespace and underscores with dashes
}
