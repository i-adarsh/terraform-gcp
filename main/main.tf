
provider "google" {
    project = var.project_id
    region  = var.region
    credentials = var.credentials
}

### Creating the VPC and the subnetework  ###
module "network" {
    source = "../module/network"
    vpc_name = var.vpc_name
    subnet_name = var.subnet_name
    region = var.region
    project_id = var.project_id
}

###  Creating a role which has permissions to read and write in the Bucket  ###
module "roles" {
    source = "../module/roles"
    project_id = var.project_id
    permissions = var.permissions
}

###  Creating Bucket  ###
module "bucket" {
    source = "../module/bucket"
    name = var.bucket_name
    location = var.location
}

### Launching an Instance ###
module "instance" {
    source = "../module/instance"
    instance_name = var.instance_name
    vpc_id = module.network.vpc_id
    subnet_id = module.network.subnet_id
    email = module.roles.bucket_role
}