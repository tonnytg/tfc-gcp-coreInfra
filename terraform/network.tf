# https://registry.terraform.io/providers/hashicorp/google/3.0.0-beta.1/docs/resources/compute_network
resource "google_compute_network" "vpc_network" {
  name                    = "my-custom-mode-network"
  auto_create_subnetworks = false
  # Maximum Transmission Unit
  mtu = 1460
}

resource "google_compute_subnetwork" "default" {
  name          = "my-custom-subnet"
  ip_cidr_range = "10.0.1.0/24"
  region        = "southamerica-east1"
  network       = google_compute_network.vpc_network.id
}