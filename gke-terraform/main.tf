// Create the GKE Cluster
resource "google_container_cluster" "primary" {
  name               = "logging"
  location           = var.zone
  initial_node_count = 2

  node_config {
    machine_type = "e2-standard-4"
    oauth_scopes = [
      "https://www.googleapis.com/auth/compute",
      "https://www.googleapis.com/auth/devstorage.read_only",
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring",
    ]
  }
  provisioner "local-exec" {
    command = "gcloud container clusters get-credentials ${google_container_cluster.primary.name} --zone ${google_container_cluster.primary.location} --project ${var.project}"
  }
}

