# Create a Artifact Registry repository to host the docker image

resource "google_artifact_registry_repository" "api" {
  location      = var.region
  repository_id = "retrieval-augmentation-api"
  description   = "API for Retrieval Augmentation example"
  format        = "DOCKER"
}

# Create a Cloud Build Trigger pointing to the GitHub Repo

resource "google_project_service_identity" "cloud_build_sa" {
  provider = google-beta
  project  = var.project_id
  service  = "cloudbuild.googleapis.com"
}

resource "google_project_iam_member" "cloudbuild_cloudrun_binding" {
  project = var.project_id
  role    = "roles/run.admin"
  member  = "serviceAccount:${google_project_service_identity.cloud_build_sa.email}"
}

resource "google_project_iam_member" "cloudbuild_sauser_binding" {
  project = var.project_id
  role    = "roles/iam.serviceAccountUser"
  member  = "serviceAccount:${google_project_service_identity.cloud_build_sa.email}"
}

resource "google_cloudbuild_trigger" "github_repo" {
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

resource "google_service_account" "cloudrun_api" {
  account_id   = "retrieval-aug-cloudrun-api"
  display_name = "Service Account for the Retrieval Augmentation Cloud Run API"
}

resource "google_project_iam_member" "cloudrun_aiplatform_binding" {
  project = var.project_id
  role    = "roles/aiplatform.user"
  member  = "serviceAccount:${google_service_account.cloudrun_api.email}"
}

resource "google_cloud_run_v2_service" "api" {
  name     = "retrieval-augmentation-api"
  location = var.region

  template {
    service_account = google_service_account.cloudrun_api.email

    containers {
      image = "us-central1-docker.pkg.dev/llmops-demos-frg/retrieval-augmentation-api/api"
      resources {
        limits = {
          memory = "3Gi"
          cpu    = "2"
        }
      }
    }
  }
}

# Allow unauthenticated (allUsers) to invoke the Cloud Run Service

resource "google_cloud_run_service_iam_binding" "unauthenticated" {
  location = google_cloud_run_v2_service.api.location
  service  = google_cloud_run_v2_service.api.name
  role     = "roles/run.invoker"
  members = [
    "allUsers"
  ]
}
