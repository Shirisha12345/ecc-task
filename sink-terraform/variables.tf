variable "zone" {
  description = "The zone in which to create the Kubernetes cluster. Must match the region"
  type        = string
  default = "europe-north1-a"
}

variable "project" {
  description = "The name of the project in which to create the Kubernetes cluster."
  type        = string
  default = "ecc-project-433415"
}

