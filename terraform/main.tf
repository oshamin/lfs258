terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = ">= 3.5.0"
    }
  }
  required_version = "~> 1.0"
  backend "remote" {
    hostname     = "app.terraform.io"
    organization = "ovshamin"

    workspaces {
      name = "lfs258"
    }
  }
}

provider "google" {
  credentials = file("lfs258-327321-0d4510056a3c.json")
  project     = "lfs258-327321"
  region      = "us-central1"
  zone        = "us-central1-c"
}

resource "google_compute_network" "vpc_network" {
  name = "terraform-network"
}


resource "google_compute_instance" "vm_instance" {
  name         = "terraform-instance"
  machine_type = "f1-micro"

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-9"
    }
  }

  network_interface {
    network = google_compute_network.vpc_network.name
    access_config {
    }
  }
}