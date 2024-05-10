import { htmlSafe } from '@ember/template';

const process = (text) =>
  htmlSafe(
    text.replaceAll('[trash]', '[trash-ability]').replaceAll('\n', '</p><p>'),
  );

<template>
  <p>
    {{process @text}}
  </p>
</template>
