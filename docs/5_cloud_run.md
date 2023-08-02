# 5. Cloud Run

We use Cloud Run to host our API.

- All the services are enabled in terraform. See the [`cloud-run.tf`](/terraform/cloud-run.tf) file
  - This section of the Terraform requires a
    [Cloud Build Repository Host Connect](https://console.cloud.google.com/cloud-build/triggers/connect).
    See the [docs](https://cloud.google.com/build/docs/automating-builds/github/connect-repo-github) for more details
- The API uses the Google Cloud Python client libraries to connect to the
  Vertex AI Matching Engine Index Endpoint to retrieve the top k nearest neighbors
- The API uses FastAPI and to expose the endpoint
- We use a custom Dockerfile to build the API image including it's depencencies
  and pre-trained models needed to generate the embeddings

TODO: Example API call and respose. Point to Notebook.

```
[
  [
    "573273bfe17f3d1400422993",
    0.6401801109313965
  ],
  [
    "56fae8528f12f3190063029f",
    0.5958483815193176
  ],
  [
    "572f39d804bcaa1900d7679d",
    0.5644943118095398
  ],
  ...
]
```

We use Cloud Build to build the deploy the API to Cloud Run.
Look at the [`cloudbuild.yml`](/cloudbuild.yml) file for more details.

## Resources

- https://cloud.google.com/build/docs/deploying-builds/deploy-cloud-run#cloud-run_1