
#####  REQUIREMENTS  #######
# Project ID inside which the whole Infrastructure will Created
variable "project_id" {
    type = string
    default = "project_id" 
    description = "Id of the project"
}

# Credential of the Owner or the User or the Service Account who will run the script
variable "credentials" {
    type = string
    default = "../cred/key.json" 
    description = "Provide the path to your key if it is in different directory"
}

# Region suitable for low latency
variable "region" {
    type = string
    default = "us-central1" # Current Region
    description = "Region suitable for low latency"
}

#========================================================================================
######  NETWORK MODULE VARIABLES  ######
# Name of your Virtual Private Cloud (VPC)
variable "vpc_name" {
    type = string
    default = "dunnhumby-vpc"
    description = "Name of your Virtual Private Cloud (VPC)"
}

# Name of your Subnetwork inside the VPC
variable "subnet_name" {
    type = string
    default = "dunnhumby-subnet"
    description = "Name of your Subnetwork"
}

#========================================================================================
# Permissions given to this role or IAM user
variable "permissions" {
    type = list(string)
    default = [
                    "storage.objects.create",
                    "storage.objects.get",
                ]
    description = "Permissions to IAM user "
}

#========================================================================================
######  BUCKET MODULE VARIABLES  ######
# Name of the Bucket to be Created (It should be Unique)
variable "bucket_name" {
    type = string
    default = "dunnhumby_adarsh_kumar"
    description = "Name of Your Bucket (It should be Unique)"
}

# Location of your Bucket according to your need
variable "location" {
    type = string
    default = "US"
    description = "Region of your Bucket"
}

#========================================================================================
####### INSTANCE MODULE VARIABLES  ######
# Name of Our Instance to be launched 
variable "instance_name" {
    type = string
    default = "dh-datapipeline"
    description = "Name of your VM Instance"
}

