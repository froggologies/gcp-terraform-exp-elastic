resource "random_id" "main_project" {
  byte_length = 3
}

# resource "random_id" "instance-1" {
#   byte_length = 3
# }

resource "random_id" "gke-1" {
  byte_length = 3
}
