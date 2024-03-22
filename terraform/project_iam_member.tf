locals {
  google = [
    "roles/editor",
  ]
  gke = [
    "roles/monitoring.metricWriter",
    "roles/logging.logWriter"
  ]
}

resource "google_project_iam_member" "google" {
  for_each = toset(local.google)

  project = google_project.main_project.project_id
  role    = each.value
  member  = "user:google@fajarmaftuhfadli.com"
}

resource "google_project_iam_member" "gke" {
  for_each = toset(local.gke)

  project = google_project.main_project.project_id
  role    = each.value
  member  = google_service_account.gke-1.member
}
