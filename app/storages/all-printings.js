import StorageObject from 'ember-local-storage/local/object';

const AllPrintingsStorage = class extends StorageObject {};

AllPrintingsStorage.reopenClass({
  initialState() {
    return {
      items: [],
      remoteUpdatedAt: null,
      updatedAt: null,
    };
  },
});

export default AllPrintingsStorage;
