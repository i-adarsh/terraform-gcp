
# Name of Our Instance to be launched 
variable "instance_name" {
    type = string
    default = "instance-1"
    description = "Name of your VM Instance"
}

# Select Configuration of your Virtual Machine (VM) according to your need and usecase 
variable "machine_types" {
    type = string
    default = "f1-micro"
    description = "Number of CPUs and cores and Memory"
}

# Selection of zone according to our need and usecase
variable "zone" {
    type = string
    default = "us-central1-a"
    description = "Deployment area for Google Cloud resources"
}

# Choosing Image of the Operating System 
variable "image_name" {
    type = string
    default = "debian-cloud/debian-10"
    description = "Image (OS)"
}

# Selection of Virtual Private Cloud (VPC) 
variable "vpc_id" {
    type = string
    default = "default"
    description = "VPC Name"
}

# Selection of Subnetwork inside our VPC
variable "subnet_id" {
    type = string
    default = "default"
    description = "Subnetwork Name"
}

# Google recommends custom service accounts that have cloud-platform scope and permissions granted via IAM Roles.
variable "email" {
    type = string
    description = "Your Service Account or Email address"
}