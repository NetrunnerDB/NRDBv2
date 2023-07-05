function maybe(val, def = 'X') {
  return val ? val : def;
}

function eq(a, b) {
  return a === b;
}

<template>
  {{#if (eq @printing.cardTypeId "agenda")}}
    {{maybe @printing.advancementRequirement}}/{{@printing.agendaPoints}}
    <i class="icon-agenda-points"></i>
  {{else if (eq @printing.cardTypeId "runner_identity")}}
    {{@printing.minimumDeckSize}}/{{maybe @printing.influenceLimit "∞"}}
    {{@printing.baseLink}}<i class="icon-link"></i>
  {{else if (eq @printing.cardTypeId "corp_identity")}}
    {{@printing.minimumDeckSize}}/{{maybe @printing.influenceLimit "∞"}}
  {{else}}
    {{maybe @printing.cost}}<i class="icon-credit"></i>

    {{#if @printing.memoryCost}}
      {{@printing.memoryCost}}<i class="icon-mu"></i>
    {{/if}}

    {{#if @printing.trashCost}}
      {{@printing.trashCost}}<i class="icon-trash-cost"></i>
    {{/if}}

    {{#if @printing.strength}}
      <br />
      Strength:
      {{@printing.strength}}
    {{/if}}
  {{/if}}
</template>
