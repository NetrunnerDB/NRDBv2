export const format = (id) => id?.toLowerCase().replace(/[ _]/g, '-');

<template>
  <div class='border-{{format @factionId}} ps-2 quote'>
    {{yield}}
  </div>
</template>
