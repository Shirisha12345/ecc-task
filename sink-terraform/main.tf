resource "google_pubsub_topic" "gke-pubsub" {
  name = "gke-logging-topic"
}


// Create the Stackdriver Export Sink for PubSub
resource "google_logging_project_sink" "pubsub-sink" {
  name        = "gke-pubsub-sink"
  destination = "pubsub.googleapis.com/projects/${var.project}/topics/${google_pubsub_topic.gke-pubsub.name}"
  filter      = "resource.type = k8s_container"

  unique_writer_identity = true
}

# // Grant the role of PubSub editor
resource "google_project_iam_binding" "log-writer-pubsub" {
  role = "roles/pubsub.editor"
  project = var.project

  members = [
    google_logging_project_sink.pubsub-sink.writer_identity,
  ]
}

resource "google_pubsub_subscription" "pubsub-subscription" {
  name  = "gke-pubsub-subscription"
  topic = google_pubsub_topic.gke-pubsub.id

  labels = {
    foo = "bar"
  }

  # 20 minutes
  message_retention_duration = "1200s"
  retain_acked_messages      = true

  ack_deadline_seconds = 20

  expiration_policy {
    ttl = "300000.5s"
  }
}

