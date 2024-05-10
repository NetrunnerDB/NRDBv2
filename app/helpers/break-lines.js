import { helper } from '@ember/component/helper';
import { htmlSafe } from '@ember/template';

export default helper(function breakLines([str]) {
  if (str == null) {
    return;
  }

  let div = document.createElement('div');
  str.split('\n').forEach((str, i) => {
    if (i > 0) {
      div.appendChild(document.createElement('br'));
      div.appendChild(document.createElement('br'));
    }
    div.appendChild(document.createTextNode(str));
  });
  return htmlSafe(div.innerHTML);
});
