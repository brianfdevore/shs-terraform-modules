provider "google" {
  version = "~> 3.34"
  project = var.project_id
}

data "google_compute_image" "source_image" {
  family  = var.source_image_family #returns the latest image from family which isn't deprecated
  project = var.project_id
}

#data "template_file" "set_os_env_variables" {
#  template = file("${path.module}/set_env.tpl")
#  vars = {
#    curr_environment   = var.env
#  }

resource "google_compute_instance" "vm_instance" {
  name                      = var.hostname
  machine_type              = var.machine_type
  tags                      = var.tags
  allow_stopping_for_update = true
  zone                      = var.zone

  boot_disk {
    initialize_params {
      image = data.google_compute_image.source_image.self_link
    }
  }

  network_interface {
    subnetwork = var.network_interface
  }

  metadata = {
    enable-oslogin  = "True"
    app-environment = var.env
    asset-owner = "Aman Wolde"
    #windows-startup-script-ps1 = TODO - https://cloud.google.com/compute/docs/startupscript
  }

  service_account {
    email  = var.svc_acct
    scopes = var.svc_acct_scopes
  }

  #metadata_startup_script = "echo Environment is: ${var.env} > C:\\test.txt"

}
