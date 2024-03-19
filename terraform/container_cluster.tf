resource "google_container_cluster" "cluster-1" {
  depends_on = [google_project_service.services.1]

  project  = google_project.main_project.project_id
  name     = "cluster-1-${random_id.gke-1.hex}"
  location = "us-central1-a"

  remove_default_node_pool = true
  initial_node_count       = 1

  network             = google_compute_network.default.name
  subnetwork          = google_compute_subnetwork.us-central1.name
  deletion_protection = false
}

resource "google_container_node_pool" "node-pool-1" {
  project    = google_project.main_project.project_id
  cluster    = google_container_cluster.cluster-1.name
  name       = "node-pool-1"
  location   = "us-central1-a"
  node_count = 1

  node_config {
    preemptible  = true
    machine_type = "e2-standard-2"

    service_account = google_service_account.gke-1.email
    oauth_scopes = [
      "https://www.googleapis.com/auth/cloud-platform"
    ]
  }
}
