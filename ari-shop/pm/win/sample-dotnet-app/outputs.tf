output "instance_source_image" {
  value = google_compute_instance.vm_instance.boot_disk.image
  description = "The source image that was used to create this instance."
}
