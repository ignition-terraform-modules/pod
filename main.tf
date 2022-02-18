data template_file "pod_service" {
  template = <<-EOS
    [Unit]
    Description=${var.name} pod create
    After=network.target

    [Service]
    User=${var.user}
    Type=oneshot
    ExecStart=/bin/podman pod create \
      %{~ for host in var.add_hosts ~}
      --add-host=${host} \
      %{~ endfor ~}
      %{~ if var.cgroup_parent != null ~}
      --cgroup-parent ${var.cgroup_parent} \
      %{~ endif ~}
      %{~ if var.cpus != null ~}
      --cpus ${var.cpus} \
      %{~ endif ~}
      %{~ if var.cpuset_cpus != null ~}
      --cpuset-cpus ${var.cpuset_cpus} \
      %{~ endif ~}
      %{~ if var.device != null ~}
      --device ${var.device} \
      %{~ endif ~}
      %{~ if var.device_read_bps != null ~}
      --device-read-bps ${var.device_read_bps} \
      %{~ endif ~}
      %{~ if var.dns != null ~}
      --dns ${var.dns} \
      %{~ endif ~}
      %{~ if var.dns_opt != null ~}
      --dns-opt ${var.dns_opt} \
      %{~ endif ~}
      %{~ if var.dns_search != null ~}
      --dns-search ${var.dns_search} \
      %{~ endif ~}
      %{~ if var.gidmap != null ~}
      --gidmap ${var.gidmap} \
      %{~ endif ~}
      %{~ if var.uidmap != null ~}
      --uidmap ${var.uidmap} \
      %{~ endif ~}
      %{~ if var.subgidname != null ~}
      --subgidname ${var.subgidname} \
      %{~ endif ~}
      %{~ if var.hostname != null ~}
      --hostname ${var.hostname} \
      %{~ endif ~}
      %{~ if var.infra != null ~}
      --infra=${var.infra} \
      %{~ endif ~}
      %{~ if var.infra_conmon_pidfile != null ~}
      --infra-conmon-pidfile ${var.infra_conmon_pidfile} \
      %{~ endif ~}
      %{~ if var.infra_command != null ~}
      --infra-command "${var.infra_command}" \
      %{~ endif ~}
      %{~ if var.infra_image != null ~}
      --infra-image ${var.infra_image} \
      %{~ endif ~}
      %{~ if var.infra_name != null ~}
      --infra-name ${var.infra_name} \
      %{~ endif ~}
      %{~ if var.ip != null ~}
      --ip ${var.ip} \
      %{~ endif ~}
      %{~ if var.ip6 != null ~}
      --ip6 ${var.ip6} \
      %{~ endif ~}
      %{~ for label in var.labels ~}
      --label ${label} \
      %{~ endfor ~}
      %{~ if var.label_file != null ~}
      --label-file ${var.label_file} \
      %{~ endif ~}
      %{~ if var.mac_address != null ~}
      --mac-address ${var.mac_address} \
      %{~ endif ~}
      %{~ if var.name != null ~}
      --name ${var.name} \
      %{~ endif ~}
      %{~ for network in var.networks ~}
      --network ${network} \
      %{~ endfor ~}
      %{~ if var.network_alias != null ~}
      --network-alias ${var.network_alias} \
      %{~ endif ~}
      %{~ if var.no_hosts ~}
      --no-hosts \
      %{~ endif ~}
      %{~ if var.pid != null ~}
      --pid ${var.pid} \
      %{~ endif ~}
      %{~ if var.pod_id_file != null ~}
      --pod-id-file ${var.pod_id_file} \
      %{~ endif ~}
      %{~ for port in var.publish ~}
      --publish ${port} \
      %{~ endfor ~}
      %{~ if var.replace ~}
      --replace \
      %{~ endif ~}
      %{~ if var.security_opt != null ~}
      --security-opt ${var.security_opt} \
      %{~ endif ~}
      %{~ if var.share != null ~}
      --share ${var.share} \
      %{~ endif ~}
      %{~ if var.share_parent != null ~}
      --share-parent ${var.share_parent} \
      %{~ endif ~}
      %{~ for sysctl in var.sysctls ~}
      --sysctl ${sysctl} \
      %{~ endfor ~}
      %{~ if var.userns != null ~}
      --userns ${var.userns} \
      %{~ endif ~}
      %{~ for volume in var.volumes ~}
      --volume ${volume} \
      %{~ endfor ~}
      %{~ if var.volumes_from != null ~}
      --volumes-from ${var.volumes_from} \
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
            "name": "${var.name}-pod-create.service",
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
