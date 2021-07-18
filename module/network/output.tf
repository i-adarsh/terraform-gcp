
# Id of created Virtual Private Cloud (VPC)
output "vpc_id" {
    value = google_compute_network.vpc_network.id
}

# Id of created Subnetwork
output "subnet_id" {
    value = google_compute_subnetwork.subnet.id
}
