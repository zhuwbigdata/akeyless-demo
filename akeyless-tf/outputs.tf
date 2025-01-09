output "instance_name" {
  description = "Name of the VM instance"
  value       = google_compute_instance.vm_instance.name
}

output "network_tag" {
  description = "Network tag assigned to the VM"
  value       = google_compute_instance.vm_instance.tags
}

output "vpc_name" {
  description = "Name of the VPC network"
  value       = google_compute_network.vpc_network.name
}


