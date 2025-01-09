provider "google" {
  project = var.project_id
  region  = var.region
  zone    = var.zone
}

# Data for exisiting IP as setup by cloud DNS
data "google_compute_address" "static_ip" {
  name         = "akeyless-gateway-static-ip"
  region       = var.region
}


# Create a VPC network
resource "google_compute_network" "vpc_network" {
  name = "my-vpc"
}

# Create a subnet
resource "google_compute_subnetwork" "subnet-1" {
  name          = "my-subnet-1"
  network       = google_compute_network.vpc_network.id
  ip_cidr_range = "10.0.0.0/24"
  region        = var.region
}


resource "google_compute_subnetwork" "subnet-2" {
  name          = "my-subnet-2"
  network       = google_compute_network.vpc_network.id
  ip_cidr_range = "10.0.1.0/24"
  region        = var.region
}


# Create a firewall rule to allow SSH from Cloud Shell
resource "google_compute_firewall" "allow_ssh_cloud_shell" {
  name    = "allow-ssh-from-cloud-shell"
  network =  google_compute_network.vpc_network.id

  # Allow ingress traffic on port 22
  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  # Source IP range for Google Cloud Shell
  source_ranges = ["35.235.240.0/20"]

  description = "Allow SSH traffic from Cloud Shell IP range"
}

# Create a firewall rule to allow HTTP and HTTPS
resource "google_compute_firewall" "allow_http_https" {
  name    = "allow-http-https"
  network = google_compute_network.vpc_network.id

  # Allow ingress traffic on port 80, 443, 8000
  allow {
    protocol = "tcp"
    ports    = ["80", "443", "8000"]
  }

  # Source IP range for Google Cloud Shell
  source_ranges = ["0.0.0.0/0"]

  description = "Allow HTTP and HTTPS traffic"
}

# Create a GCE instance with the 'gateway' network tag
resource "google_compute_instance" "vm_instance" {
  name         = "akeyless-gateway"
  machine_type = "e2-micro"
  zone         = var.zone

  boot_disk {
    initialize_params {
       image = "ubuntu-2004-focal-v20241219"
    }
  }

  network_interface {
    network    = google_compute_network.vpc_network.id
    subnetwork = google_compute_subnetwork.subnet-1.id
    access_config {
      # Static public IP
      nat_ip = data.google_compute_address.static_ip.address
      network_tier = "STANDARD"
    }
  }

  tags = ["gateway"]

  metadata = {
    enable-oslogin = "TRUE"
  }
}

