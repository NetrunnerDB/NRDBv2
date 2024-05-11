import { htmlSafe } from '@ember/template';

const process = (text) =>
  htmlSafe(
    text
      .replaceAll('[trash]', '[trash-ability]')
      .replace(/\[([^\d]*?)\]/g, '<i class="icon-$1"></i>') // Convert icons
      .replaceAll('\n', '</p><p>'),
  );

<template>
  <p>
    {{process @text}}
  </p>
</template>
