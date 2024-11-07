import MarkdownToHtml from 'ember-cli-showdown/components/markdown-to-html';
import { formatDate } from 'netrunnerdb/helpers/format-date';

<template>
  <div class='ruling'>
    <div class='ruling-header'>
      {{#if @ruling.nsgRulesTeamVerified}}
        <span class='legality-verified'></span>
      {{else}}
        <span class='legality-unverified'></span>
      {{/if}}
      <span class='fst-italic ms-1 font-size-14'>
        Updated
        {{formatDate @ruling.updatedAt}}
      </span>
    </div>
    {{#if @ruling.question}}
      <div class='ruling-question'>
        <MarkdownToHtml @markdown={{@ruling.question}} />
      </div>
      <div class='ruling-answer mt-2'>
        <MarkdownToHtml @markdown={{@ruling.answer}} />
      </div>
    {{else}}
      <div class='ruling-text'>
        <MarkdownToHtml @markdown={{@ruling.textRuling}} />
      </div>
    {{/if}}
  </div>
</template>
