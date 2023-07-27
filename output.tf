output "project_id" {
  value       = var.project_id
  description = "The ID of the project in which resources are created."
}

output "region" {
  value       = var.region
  description = "The region in which resources are created."
}

output "zone" {
  value       = var.zone
  description = "The zone in which resources are created."
}

output "subnet_cidr" {
  value       = var.subnet_cidr
  description = "The CIDR block for the subnet."
}

output "machine_type" {
  value       = var.machine_type
  description = "The machine type for the instance."
}

output "image" {
  value       = var.image
  description = "The image from which the instance is created."
}

output "vpc_name" {
  value       = google_compute_network.vpc.name
  description = "The name of the VPC network."
}

output "subnet_name" {
  value       = google_compute_subnetwork.subnet.name
  description = "The name of the subnet."
}

output "firewall_name" {
  value       = google_compute_firewall.firewall.name
  description = "The name of the firewall."
}

output "static_ip_names" {
  value       = [for i in google_compute_address.static_ip : i.name]
  description = "The names of the static IP addresses."
}

output "static_ip_addresses" {
  value       = [for i in google_compute_address.static_ip : i.address]
  description = "The static IP addresses."
}

output "instance_names" {
  value       = google_compute_instance.vm_instance[*].name
  description = "The names of the VM instances."
}

output "instance_external_ips" {
  value       = google_compute_instance.vm_instance[*].network_interface[0].access_config[0].nat_ip
  description = "The external IP addresses of the VM instances."
}