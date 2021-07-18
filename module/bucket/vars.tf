# Name of the Bucket to be Created (It should be Unique)
variable "name" {
    type = string
    description = "Name of Your Bucket (It should be Unique)"
}

# Location of your Bucket according to your need
variable "location" {
    type = string
    default = "US"
    description = "Region of your Bucket"
}

