
# Name of your Virtual Private Cloud (VPC)
variable "vpc_name" {
    type = string
    default = "default"
    description = "Name of your Virtual Private Cloud (VPC)"
}

# Name of your Subnetwork inside the VPC
variable "subnet_name" {
    type = string
    default = "default"
    description = "Name of your Subnetwork"
}

# Region suitable for low latency
variable "region" {
    type = string
    default = "us-central1"
    description = "Choose which region hosts your resources"
}

# Project ID inside which the whole Infrastructure will Created
variable "project_id" {
    type = string
    description = "Project Id in which you want to create the VPC and Subnetwork"
}
