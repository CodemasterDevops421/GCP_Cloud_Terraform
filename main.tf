provider "google" {
  project = var.project_id
  region  = var.region
  zone    = var.zone
}

resource "google_compute_network" "vpc" {
  name                    = "demo-vpc"
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "subnet" {
  name          = "demo-subnet"
  ip_cidr_range = var.subnet_cidr
  network       = google_compute_network.vpc.self_link
}

resource "google_compute_firewall" "firewall" {
  name    = "demo-firewall"
  network = google_compute_network.vpc.name

  allow {
    protocol = "icmp"
  }

  allow {
    protocol = "tcp"
    ports    = ["22", "80", "443", "8080"]
  }

  source_ranges = ["0.0.0.0/0"]
}

resource "google_compute_address" "static_ip" {
  count = var.instance_count
  name  = "demo-ip-${count.index}"
}

resource "google_compute_instance" "vm_instance" {
  count        = var.instance_count
  name         = "${var.instance_name_prefix}-${count.index}"
  machine_type = var.machine_type

  boot_disk {
    initialize_params {
      image = var.image
    }
  }

  network_interface {
    subnetwork = google_compute_subnetwork.subnet.self_link

    access_config {
      nat_ip = google_compute_address.static_ip[count.index].address
    }
  }

  metadata_startup_script = <<-EOF
                              sudo apt-get update && sudo apt-get upgrade -y
                              sudo apt-get install docker.io -y
                              sudo systemctl start docker
                              sudo systemctl enable docker
                              sudo usermod -aG docker $USER
                              sudo apt-get install docker-compose -y
                              sudo docker run -d -p 80:80 nginx
                            EOF
}

resource "google_storage_bucket" "bucket" {
  name     = "demo12-bucket23"
  location = var.region
  project  = var.project_id

  lifecycle_rule {
    action {
      type = "Delete"
    }

    condition {
      age = 365
    }
  }
}