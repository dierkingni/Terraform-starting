locals {
    project_id = "mms-clp-playground2402-a-i2ar"
}

provider "google" {
    project = local.project_id
    region  = "europe-west4"
}

resource "google_container_cluster" "my-playground-cluster" {
  name     = "my-playground-cluster"
  location = "europe-west-4"

  # We can't create a cluster with no node pool defined, but we want to only use
  # separately managed node pools. So we create the smallest possible default
  # node pool and immediately delete it.
  remove_default_node_pool = true
  initial_node_count       = 1
}

resource "google_container_node_pool" "pool-a" {
  name       = "pool-a"
  location   = "europe-west-4"
  cluster    = google_container_cluster.my-playground-cluster.name
  node_count = 3

  node_config {
    preemptible  = true
    machine_type = "e2-micro"
  }
}