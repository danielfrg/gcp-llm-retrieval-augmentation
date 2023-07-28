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

resource "google_service_account" "cloudrun-api" {
  account_id   = "retreival-aug-cloudrun-api"
  display_name = "Service Account for the Retrieval Augmentation Cloud Run API"
}

resource "google_project_iam_member" "sa-ai-user-binding" {
  project = var.project_id
  role    = "roles/aiplatform.user"
  member  = "serviceAccount:${google_service_account.cloudrun-api.email}"
}

resource "google_cloud_run_service" "api" {
  name     = "retreival-augmentation-api"
  location = var.region

  template {
    spec {
      service_account_name = google_service_account.cloudrun-api.email
      containers {
        image = "us-central1-docker.pkg.dev/langchain-llmops/retrieval-augmentation-api/api"
        resources {
          limits = {
            memory = "2Gi"
            cpu    = "1000m"
          }
          requests = {
            memory = "2Gi"
            cpu    = "1000m"
          }
        }
      }
    }
  }

  traffic {
    percent         = 100
    latest_revision = true
  }
}
