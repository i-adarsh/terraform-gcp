
######### Custom Role #########
# To access this feature first we have to enable the IAM API, and for enabling we have to go the following URL. 
# https://console.developers.google.com/apis/api/iam.googleapis.com/overview?project=344191581751

# Creating Custom Role for Accessing Bucket
resource "google_project_iam_custom_role" "bucket-access" {
    role_id     = "bucketRole"
    title       = "My Bucket Role"
    description = "Custom Role for VM so that it can only read and write in the bucket"
    permissions = var.permissions
}


# Creating new Service Account (a kind of IAM user) for Binding the above role so that it can can interact with bucket with only read and write permissions
resource "google_service_account" "sa" {
    account_id   = "bucket-role"
    display_name = "A service account that can interact with bucket with only read and write permissions"
}

# Binding the Custom Role with the new Service Account created
resource "google_project_iam_binding" "project" {
    project = var.project_id
    role    = "${google_project_iam_custom_role.bucket-access.id}"
    members = [
    "serviceAccount:${google_service_account.sa.email}"
    ]
}