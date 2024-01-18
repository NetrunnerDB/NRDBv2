import Model, { attr, belongsTo, hasMany } from '@ember-data/model';

export default class PrintingModel extends Model {
  // General
  @attr cardId;
  @attr cardCycleId;
  @attr cardCycleName;
  @attr cardSetId;
  @attr cardSetName;
  @attr flavor;
  @attr displayIllustrators;
  @attr illustratorIds;
  @attr illustratorNames;
  @attr position;
  @attr quantity;
  @attr dateRelease;
  @attr images;
  @attr releasedBy;

  // Misc
  @attr updatedAt;

  // Relationships
  @belongsTo('card', { async: true, inverse: 'printings' }) card;
  @belongsTo('card-cycle', { async: true, inverse: 'printings' }) cardCycle;
  @belongsTo('card-set', { async: true, inverse: 'printings' }) cardSet;
  @belongsTo('card-type', { async: true, inverse: null }) cardType;
  @belongsTo('faction', { async: true, inverse: 'printings' }) faction;
  @belongsTo('side', { async: true, inverse: 'printings' }) side;
  @hasMany('illustrator', { async: true, inverse: 'printings' }) illustrators;

  // Card::Universal
  @attr strippedTitle;
  @attr title;
  @attr strippedText;
  @attr text;
  @attr cardTypeId;
  @attr sideId;
  @attr factionId;
  @attr deckLimit;
  @attr numPrintings;
  @attr printingIds;
  @attr isUnique;
  @attr cardSubtypeIds;
  @attr displaySubtypes;
  @attr cardAbilities;
  @attr designedBy;

  // Card::General
  @attr cost;
  @attr influenceCost;
  @attr memoryCost;
  @attr strength;
  @attr trashCost;
  @attr attribution;

  // Card::ID
  @attr baseLink;
  @attr influenceLimit;
  @attr minimumDeckSize;

  // Card::Agenda
  @attr advancementRequirement;
  @attr agendaPoints;

  // Card::Meta
  @attr inRestriction;
  @attr restrictionIds;
  @attr formatIds;
  @attr cardPoolIds;
  @attr snapshotIds;
  @attr restrictions;
}
