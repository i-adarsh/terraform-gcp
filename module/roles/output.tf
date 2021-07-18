
# Generated IAM Service Account which has permissions to read and write in bucket
output "bucket_role" {
    value = google_service_account.sa.email
}