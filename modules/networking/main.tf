resource "google_compute_network" "vpc_network" {
    name = var.network_name
    auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "subnet" {
    name = var.subnet_name
    ip_cidr_range = var.subnet_cidr # The IP address range that machines in this network are assigned to, represented as a CIDR block.
    region = var.region
    network = google_compute_network.vpc_network.id
}

resource "google_compute_firewall" "allow_http" {
    name = "allow-http"
    network = google_compute_network.vpc_network.name

    allow {
        protocol = "tcp"
        ports = ["80"]
    }

    source_ranges = ["0.0.0.0/0"]    # from anywhere
    target_tags = ["web"]            # to instances with this tag
}