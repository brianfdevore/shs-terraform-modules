output "instance_source_image" {
  value = data.google_compute_image.source_image
  description = "The source image that was used to create this instance."
}
