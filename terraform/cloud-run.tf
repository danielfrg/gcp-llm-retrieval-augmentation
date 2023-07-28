# Create a Artifact Registry repository to host the docker image

resource "google_artifact_registry_repository" "api" {
  location      = var.region
  repository_id = "retrieval-augmentation-api"
  description   = "API for Retrieval Augmentation example"
  format        = "DOCKER"
}

# Create a Cloud Build Trigger pointing to the GitHub Repo

resource "google_cloudbuild_trigger" "include-build-logs-trigger" {
  location = var.region
  name     = "retrieve-augment-api"
  filename = "cloudbuild.yaml"

  github {
    owner = "danielfrg"
    name  = "gcp-llm-retrieval-augmentation"
    push {
      branch = "^main$"
    }
  }

  include_build_logs = "INCLUDE_BUILD_LOGS_WITH_STATUS"
}
