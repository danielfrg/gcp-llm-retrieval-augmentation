# 5. Cloud Run

Now that we have all the code for our LangChain RetreivalQA agent we take this
code and create a Cloud Run API to expose the functionality.

- All the services are enabled in terraform. See the [`cloud-run.tf`](/terraform/cloud-run.tf) file
  - This section of the Terraform requires a
    [Cloud Build Repository Host Connect](https://console.cloud.google.com/cloud-build/triggers/connect).
    See the [docs](https://cloud.google.com/build/docs/automating-builds/github/connect-repo-github) for more details
- The API uses the Google Cloud Python client libraries to connect to the
  Vertex AI Matching Engine Index Endpoint to retrieve the top k nearest neighbors
- The API uses FastAPI and to expose the endpoint
- We use a custom Dockerfile to build the API image including it's depencencies
  and pre-trained models needed to generate the embeddings

The source for the API can be found at [`api/main.py`](/api/main.py).

The API exposes two endpoints:

1. For only retrieving the top k nearest neighbors
2. A full QA system that takes a query and uses Vertex AL PaLM to generate an answer

A version of this API and an OpenAPI endpoint is [available here](https://retrieval-augmentation-api-uowebtbapa-uc.a.run.app/docs).

## Cloud BUild

We use Cloud Build to take the source code, dependencies and Dockerfile to build
a Docker contianer, upload it to Google Artifact Registry and deploy it to Cloud Run.
Look at the [`cloudbuild.yml`](/cloudbuild.yml) file for more details.

## Next steps

We can create a simple web UI to interact with the API.

## Resources

- https://cloud.google.com/build/docs/deploying-builds/deploy-cloud-run#cloud-run_1
