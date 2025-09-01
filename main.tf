
data "google_service_account" "gcp_cicd_sa" {
    account_id = "gcp-cicd-sa"
  
}

data "google_compute_network" "project_vpc" {
    name = "project-vpc"
    project = var.project
  
}

data "google-comput_subnetwork" "project_vpc_subnet" {
  name = "project-vpc-subnet"
  project = var.project
}

# resource "google_service_account" "gcp_cicd_sa" {
#     account_id = "gcp-cicd-sa"
#     display_name = "gcp-cicd-sa"  
# }

resource "google_compute_instance" "jenkins_test_vm" {
    name = "jenkins-testvm"
    machine_type = "e2-medium"
    
    boot_disk {
      initialize_params {
        image = "ubuntu-os-cloud/ubuntu-2404-lts-arm64"
        size= 20
      }
    }

    network_interface {
      network = data.google_compute_subnetwork.project_vpc_subnet.self_link
      access_config {}
    }
}