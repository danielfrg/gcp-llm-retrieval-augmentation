# 3. Cloud Run

We use Cloud Run to host our API.

- All the services are enabled in terraform. See the [`cloud-run.tf`](/terraform/cloud-run.tf) file
- The API uses the Google Cloud Python client libraries to connect to the
  Vertex AI Matching Engine Index Endpoint to retrieve the top k nearest neighbors
- The API uses FastAPI and to expose the endpoint
- We use a custom Dockerfile to build the API image including it's depencencies
  and pre-trained models needed to generate the embeddings

We use Cloud Build to build the deploy the API to Cloud Run.
Look at the [`cloudbuild.yml`](/cloudbuild.yml) file for more details.

## Resources

- https://cloud.google.com/build/docs/deploying-builds/deploy-cloud-run#cloud-run_1
