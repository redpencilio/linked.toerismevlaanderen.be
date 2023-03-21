export default [
  {
    match: {
      predicate: {
        type: 'uri',
        value: 'http://purl.org/dc/terms/type'
      },
      object: {
        type: 'uri',
        value: 'http://linked.toerismevlaanderen.be/id/dataset-types/ca82a1e3-8a7c-438e-ba37-cf36063ba060'
      }
    },
    callback: {
      url: 'http://dataset-generator/delta',
      method: 'POST'
    },
    options: {
      resourceFormat: 'v0.0.1',
      gracePeriod: 250,
      ignoreFromSelf: true
    }
  },
  {
    match: {
      // form of element is {subject,predicate,object}
    },
    callback: {
      url: 'http://resource/.mu/delta',
      method: 'POST'
    },
    options: {
      resourceFormat: 'v0.0.1',
      gracePeriod: 250,
      ignoreFromSelf: true
    }
  }
];
