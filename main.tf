data template_file "pod_service" {
  template = <<-EOS
    [Unit]
    Description=${var.name} Setup
    After=network.target

    [Service]
    User=${var.user}
    Type=oneshot
    ExecStart=/bin/podman create pod \
      %{~ for host in var.add_hosts ~}
      --add-host=${host} \
      %{~ endfor ~}
      %{~ if cgroup_parent != null ~}
      --cgroup-parent ${var.cgroup_parent}
      %{~ endif ~}

    [Install]
    WantedBy=multi-user.target
    EOS
}

data template_file "ignition" {
  template = <<-EOI
    {
      "ignition": {
        "version": "3.3.0"
      },
      "systemd": {
        "units": [
          {
            "name": "${var.pod_name}-pod-setup.service",
            "enabled": true,
            "contents": ${jsonencode(data.template_file.pod_service.rendered)}
          }
        ]
      }
    }
    EOI
}

locals {
  # Checks that ignition is valid JSON. Helps spot simple serialization bugs.
  validate_ignition = jsondecode(data.template_file.ignition.rendered)
}
