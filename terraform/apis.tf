variable "services" {
  type = list(string)
  default = [
    "aiplatform.googleapis.com",
    "run.googleapis.com",
    "cloudbuild.googleapis.com",
    "artifactregistry.googleapis.com",
  ]
}

resource "google_project_service" "services" {
  for_each = toset(var.services)
  project  = var.project_id
  service  = each.value
}
