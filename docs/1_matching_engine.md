# 1. Matching Engine

Most of the configuration is managed by terraform with the exception of a couple of commands that need to be run manually.

The terraform configuration will create the following resources:

- GCP Bucket
- VertexAI Matching Engine Index
  - Configured for using the GCP bucket as a data source
  - Configured to be updated in batch mode
- VertexAI Matching Engine Index Endpoint

Create a `terraform/terraform.tfvars` file with the following variables:

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

The terraform configuration will output the following variables that will be
used in the next steps:

```plain
Outputs:

index_endpoint_id = "XXXX"
index_id = "YYYY"
```

Deploy the index to the index endpoint:

```plain
gcloud ai index-endpoints deploy-index <index_endpoint_id> \
  --deployed-index-id=<my-deployed-index-id> \
  --display-name=<deployed-index> \
  --index=<index_id>
  --region us-central1
```

For more info check the [official documentation](https://cloud.google.com/vertex-ai/docs/matching-engine/match-eng-setup/match-eng-setup).
