
######  Launching New Instance ######
resource "google_compute_instance" "default" {
    name         = var.instance_name
    machine_type = var.machine_types
    zone         = var.zone
    tags = ["foo", "bar"]

    boot_disk {
    initialize_params {
        image = var.image_name
    }
    }

    # Selecting Network Interface
    network_interface {
        network = var.vpc_id
        subnetwork = var.subnet_id
        access_config {
            //
        }
    }

    metadata = {
        foo = "bar"
    }

    # This script will run at the time of launching to configure the Docker Services and Starting the webserver on port 8080
    metadata_startup_script = "${file("./script.sh")}"

    service_account {
        # Google recommends custom service accounts that have cloud-platform scope and permissions granted via IAM Roles.
        email  = var.email
        # Permissions of read and write only in bucket
        scopes = ["https://www.googleapis.com/auth/devstorage.read_write"]
    }
}