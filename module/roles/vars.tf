# Project ID inside which role is created
variable "project_id" {
    type = string
    description = "Project ID inside which role is created"
}

# Permissions given to this role or IAM user
variable "permissions" {
    type = list(string)
    description = "Permissions to IAM user "
}