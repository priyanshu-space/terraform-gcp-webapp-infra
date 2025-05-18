variable "region" {}

variable "zone" {
    type = list(string)
}

variable "machine_type" {
    default = "e2-medium"
}

variable "source_image" {
    default = "projects/debian-cloud/global/images/family/debian-11"
}

variable "subnet_self_link" {}

variable "target_size" {
    default = 2 
}

variable "distribution_policy_zones" {
  description = "List of zones for the regional instance group"
  type        = list(string)
  default     = ["us-central1-a", "us-central1-b"]
}