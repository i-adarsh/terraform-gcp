
######  Creating New Bucket  ###### 
resource "google_storage_bucket" "bucket" {
    name          = var.name
    location      = var.location
    # This option will delete the bucket, even any file or object is present in the bucket.
    force_destroy = true
}
