self.deprecationWorkflow = self.deprecationWorkflow || {};
self.deprecationWorkflow.config = {
  workflow: [
    { handler: 'silence', matchId: 'ember-data:deprecate-array-like' },
    { handler: 'silence', matchId: 'ember-data:deprecate-non-strict-types' },
    {
      handler: 'silence',
      matchId: 'ember-data:deprecate-promise-many-array-behaviors',
    },
    { handler: 'silence', matchId: 'ember-data:no-a-with-array-like' },
    { handler: 'silence', matchId: 'ember-modifier.use-destroyables' },
    { handler: 'silence', matchId: 'ember-modifier.use-modify' },
    { handler: 'silence', matchId: 'ember-modifier.no-element-property' },
    { handler: 'silence', matchId: 'ember-modifier.no-args-property' },
  ],
};
