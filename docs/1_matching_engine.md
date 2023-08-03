# 1. Matching Engine

Most of the infrastructure of this project is managed by terraform with the exception of a couple of commands that need to be run manually.

The terraform configuration will create the following resources:

- Enable all required services
- Create the different Service Accounts with the required permissions
- GCP Bucket to store the embeddings
- VertexAI Matching Engine Index
  - Configured for using the GCP bucket as a data source
  - Configured to be updated in batch mode
- VertexAI Matching Engine Index Endpoint
- Cloud Run service to host the API
- Cloud Build triggers to deploy the API from GitHub

## Gettings started

You need a couple of variables before gettings started. Create a `terraform/terraform.tfvars` file with the following variables:

```terraform
project_id  = "the-project-name"
bucket_name = "my-bucket"

# Optional
region = ""  # Defaults to us-central1
```

Run `terraform apply`, review the changes and confirm:

```plain
cd terraform
terraform apply
```

Note: This step might take up to an hour to complete.

The terraform configuration will output the following variables that will be
used in the next steps:

```plain
Outputs:

index_endpoint_id = "XXXX"
index_id = "YYYY"
```

Note that at any point you can get the value of these variables by running:

```plain
terraform output
```

Deploy the index to the index endpoint:

```plain
gcloud ai index-endpoints deploy-index <tf_index_endpoint_id> \
  --index=<tf_index_id> \
  --deployed-index-id=<deployed-index-id> \
  --display-name=<deployed-index-name> \
  --region us-central1
```

- `deployed-index-id`: Any name that identifies the deployed index, should start with a letter and contain only letters
- `deployed-index-name`: Display name for the deployed index
- `tf_index_endpoint_id`: The value of the `index_endpoint_id` terraform output
- `tf_index_id`: The value of the `index_id` terraform output

For more info check the [official documentation](https://cloud.google.com/vertex-ai/docs/matching-engine/match-eng-setup/match-eng-setup).
