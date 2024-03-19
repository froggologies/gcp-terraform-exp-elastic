# resource "google_service_account" "instance-1" {
#   project    = google_project.main_project.project_id
#   account_id = "instance-1-${random_id.instance-1.hex}"
# }

resource "google_service_account" "gke-1" {
  project    = google_project.main_project.project_id
  account_id = "gke-1-${random_id.gke-1.hex}"
}
