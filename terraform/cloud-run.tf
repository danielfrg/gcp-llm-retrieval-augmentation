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
  filename = "cloudbuild.yml"

  github {
    owner = "danielfrg"
    name  = "gcp-llm-retrieval-augmentation"
    push {
      branch = "^main$"
    }
  }

  include_build_logs = "INCLUDE_BUILD_LOGS_WITH_STATUS"
}

# Create the Cloud Run Service

resource "google_cloud_run_service" "api" {
  name     = "retreival-augmentation-api"
  location = var.region

  template {
    spec {
      containers {
        image = "us-central1-docker.pkg.dev/langchain-llmops/retrieval-augmentation-api/api"
      }
    }
  }

  traffic {
    percent         = 100
    latest_revision = true
  }
}
