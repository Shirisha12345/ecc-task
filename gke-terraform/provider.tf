provider "google" {
  project = var.project
}

terraform {
  required_providers {
    google = {
      version = "~> 2.11.0"
    }
  }
}