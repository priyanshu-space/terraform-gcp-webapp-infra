resource "google_compute_instance_template" "default" {
    name_prefix = "web-template-"                              # adds "web-template" prefix to the random names of VMs generated by the GCP.
    machine_type = var.machine_type
    region = var.region

    tags = ["web"]

    disks {
        source_image = var.source_image
        auto_delete = true
        boot = true
    }

    network_interface {
      subnetwork = var.subnet_self_link                        # A self_link is the full URL of a GCP resource
      access_config {} # for external IP
    }

    metadata_startup_script = file("${path.module}/startup.sh")
}

resource "google_compute_region_instance_group_manager" "web_mig" {
    name = "web-mig"
    base_instance_name = "web"
    region = var.region
    distribution_policy_zones = var.distribution_policy_zones

    version {
        instance_template = google_compute_instance_template.default.self_link
    }

    target_size = var.target_size
    named_port {
        name = "http"
        port = 80
    }
}