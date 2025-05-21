provider "google" {
    project = var.project_id
    region = var.region
    zone = var.zone
}

module "networking" {
    source = "./modules/networking"
    network_name = "webapp-vpc"
    subnet_name = "webapp-subnet"
    subnet_cidr = "10.10.0.0/24"
    region = var.region

}

module "compute" {
    source = "./modules/compute"
    region = var.region
    zones = ["us-central1-a", "us-central1-b"]
    subnet_self_link = module.networking.subnet_name
    target_size = 2
}

module "loadbalancer" {
    source = "./modules/loadbalancer"
    instance_group = module.compute.instance_group
}