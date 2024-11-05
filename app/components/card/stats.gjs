import { eq, maybe } from 'netrunnerdb/utils/template-operators';
import Icon from 'netrunnerdb/components/icon';

<template>
  {{#if (eq @printing.cardTypeId 'agenda')}}
    {{maybe @printing.advancementRequirement}}/{{@printing.agendaPoints}}
    <Icon @icon='agenda-points' />
  {{else if (eq @printing.cardTypeId 'runner_identity')}}
    ({{@printing.minimumDeckSize}}/{{maybe @printing.influenceLimit '∞'}})
    {{@printing.baseLink}}<Icon @icon='link' />
  {{else if (eq @printing.cardTypeId 'corp_identity')}}
    ({{@printing.minimumDeckSize}}/{{maybe @printing.influenceLimit '∞'}})
  {{else}}
    {{maybe @printing.cost}}<Icon @icon='credit' />

    {{#if @printing.memoryCost}}
      {{@printing.memoryCost}}<Icon @icon='mu' />
    {{/if}}

    {{#if @printing.trashCost}}
      {{@printing.trashCost}}<Icon @icon='trash-cost' />
    {{/if}}

    {{#if @showStrength}}
      {{#if @printing.strength}}
        <br />
        Strength:
        {{@printing.strength}}
      {{/if}}
    {{/if}}
  {{/if}}
</template>
