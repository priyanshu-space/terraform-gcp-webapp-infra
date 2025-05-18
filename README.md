# terraform-gcp-webapp-infra

*Prerequisites*
 * Terraform CLI
 * GCP account
 * Git + Github

 *Q/A* :

1. Why use self_link instead of just the subnet name?

 * It uniquely identifies the subnetwork across all regions and projects.
 * GCP APIs often require the full self_link to avoid ambiguity.
 * It ensures you’re attaching to the exact subnet you intend — even across environments.
