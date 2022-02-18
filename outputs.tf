output "ignition" {
  description = "The contents of the ignition file."
  value = data.template_file.ignition.rendered
  sensitive = true
}

output "systemd_service_name" {
  description = "The name of the pod create systemd service file."
  value = "${var.name}-pod-create.service"
}

output "pod_name" {
  description = "The name of the pod."
  value = var.name
}