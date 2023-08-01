terraform {
  required_providers {
    google = {
      source = "hashicorp/google"
    }
  }
}

provider "google" {
  project = var.project_id
  region  = var.region
}

variable "region" {
  type    = string
  default = "us-central1"
}

variable "project_id" {
  type = string
}

variable "bucket_name" {
  type = string
}
