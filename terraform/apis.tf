variable "services" {
  type = list(string)
  default = [
    "aiplatform.googleapis.com"
  ]
}

resource "google_project_service" "services" {
  for_each = toset(var.services)
  project  = var.project_id
  service  = each.value
}
