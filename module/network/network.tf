
######  Creating Virtual Private Cloud (VPC)  ######  
resource "google_compute_network" "vpc_network" {
    name                    = var.vpc_name
    auto_create_subnetworks = "false"
}

######  Creating Subnets Inside our VPC  ######  
resource "google_compute_subnetwork" "subnet" {
    name          = var.subnet_name
    ip_cidr_range = "10.0.1.0/24"
    region        = var.region
    network       = google_compute_network.vpc_network.id
}


######  Creating Firewall Rules ######  
# Creating Firewall rules so that we can connect with our Instances

# Allowing icmp protocol, so that we are able to ping our machine
resource "google_compute_firewall" "firewall-allow-icmp" {
    name    = "allow-icmp"
    project                 = var.project_id
    source_ranges           = ["0.0.0.0/0"]
    network = google_compute_network.vpc_network.id
    priority                = 65534
    allow {
        protocol = "icmp"
    }

    source_tags = ["icmp"]
}

# Allowing port 80 for HTTP webserver
resource "google_compute_firewall" "firewall-allow-http" {
    name    = "allow-http"
    project                 = var.project_id
    source_ranges           = ["0.0.0.0/0"]
    direction               = "INGRESS"
    network = google_compute_network.vpc_network.id

    allow {
        protocol = "tcp"
        ports    = ["80"]
    }

    source_tags = ["http"]
}

# Allowing port 443 for HTTPS webserver
resource "google_compute_firewall" "firewall-allow-https" {
    name    = "allow-https"
    project                 = var.project_id
    source_ranges           = ["0.0.0.0/0"]
    direction               = "INGRESS"
    network = google_compute_network.vpc_network.id

    allow {
        protocol = "tcp"
        ports    = ["443"]
    }

    source_tags = ["https"]
}

# Allowing port 8080 so that we can connect with our docker image
resource "google_compute_firewall" "firewall-allow-docker" {
    name    = "allow-docker"
    project                 = var.project_id
    source_ranges           = ["0.0.0.0/0"]
    direction               = "INGRESS"
    network = google_compute_network.vpc_network.id

    allow {
        protocol = "tcp"
        ports    = ["8080"]
    }

    source_tags = ["docker"]
}

# Firewall to allow internal
resource "google_compute_firewall" "firewall-allow-internal" {
    name    = "allow-internal"
    project                 = var.project_id
    source_ranges           = ["0.0.0.0/0"]
    direction               = "INGRESS"
    network = google_compute_network.vpc_network.id
    priority                = 65534
    allow {
        protocol = "tcp"
        ports    = ["0-65535"]
    }

    allow {
        protocol = "udp"
        ports    = ["0-65535"]
    }

    allow {
        protocol = "icmp"
    }

    source_tags = ["internal"]
}

# Allowing ssh, so that we can connect with our Instances
resource "google_compute_firewall" "ssh-rules" {
    name                    = "allow-ssh-ingress"
    description             = null
    direction               = "INGRESS"
    network                 = google_compute_network.vpc_network.id
    project                 = var.project_id
    source_ranges           = ["0.0.0.0/0"]
    priority                = 65534
    allow {
        protocol = "tcp"
        ports    = ["22"]
    }

    log_config {
        metadata = "INCLUDE_ALL_METADATA"
    }
}

#######  Health Check #######
# Health Check for Port 8080, so that if any issue came in connecting it will inform us.

# Creating Health Check
resource "google_compute_health_check" "hc" {
    name               = "proxy-health-check"
    check_interval_sec = 1
    timeout_sec        = 1

    tcp_health_check {
        port = "8080"
    }
}

# Health Checking
resource "google_compute_region_backend_service" "backend" {
    name          = "compute-backend"
    region        = var.region
    health_checks = [google_compute_health_check.hc.id]
}

##### Adding route to VPC  ######
resource "google_compute_forwarding_rule" "default" {
    name     = "compute-forwarding-rule"
    region   = var.region

    load_balancing_scheme = "INTERNAL"
    backend_service       = google_compute_region_backend_service.backend.id
    all_ports             = true
    network               = google_compute_network.vpc_network.id
    subnetwork            = google_compute_subnetwork.subnet.id
}

resource "google_compute_route" "route-ilb" {
    name         = "route-ilb"
    dest_range   = "0.0.0.0/0"
    network               = google_compute_network.vpc_network.id
    next_hop_ilb = google_compute_forwarding_rule.default.id
    priority     = 2000
}