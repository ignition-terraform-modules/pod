# https://docs.podman.io/en/latest/markdown/podman-pod-create.1.html

variable "user" {
  description = "User to execute the systemd unit under."
  type = string
  default = "core"
}

variable "add_hosts" {
  description = "Add a host to the /etc/hosts file shared between all containers in the pod."
  type = list(string)
  default = []
}

variable "cgroup_parent" {
  description = "Path to cgroups under which the cgroup for the pod will be created."
  type = string
  default = null
}

variable "cpus" {
  description = "Set the total number of CPUs delegated to the pod."
  type = number
  default = null
}

variable "cpuset_cpus" {
  description = "Limit the CPUs to support execution."
  type = string
  default = null
}

variable "device" {
  description = "Add a host device to the pod."
  type = string
  default = null
}

variable "device_read_bps" {
  description = "Limit read rate (bytes per second) from a device."
  type = string
  default = null
}

variable "dns" {
  description = "Set custom DNS servers in the /etc/resolv.conf file that will be shared between all containers in the pod."
  type = string
  default = null
}

variable "dns_opt" {
  description = "Set custom DNS options in the /etc/resolv.conf file that will be shared between all containers in the pod."
  type = string
  default = null
}

variable "dns_search" {
  description = "Set custom DNS search domains in the /etc/resolv.conf file that will be shared between all containers in the pod."
  type = string
  default = null
}

variable "gidmap" {
  description = "GID map for the user namespace."
  type = string
  default = null
}

variable "uidmap" {
  description = "Run the container in a new user namespace using the supplied mapping. "
  type = string
  default = null
}

variable "subgidname" {
  description = "Name for GID map from the /etc/subgid file."
  type = string
  default = null
}

variable "subuidname" {
  description = "Name for UID map from the /etc/subuid file."
  type = string
  default = null
}

variable "hostname" {
  description = "Name for UID map from the /etc/subuid file."
  type = string
  default = null
}

variable "infra" {
  description = "Create an infra container and associate it with the pod."
  type = string
  default = null
}

variable "infra_conmon_pidfile" {
  description = "Write the pid of the infra container’s conmon process to a file."
  type = string
  default = null
}

variable "infra_command" {
  description = "The command that will be run to start the infra container."
  type = string
  default = null
}

variable "infra_image" {
  description = "The custom image that will be used for the infra container."
  type = string
  default = null
}

variable "infra_name" {
  description = "The name that will be used for the pod’s infra container."
  type = string
  default = null
}

variable "ip" {
  description = "Specify a static IP address for the pod, for example 10.88.64.128."
  type = string
  default = null
}

variable "ip6" {
  description = "Specify a static IPv6 address for the pod, for example fd46:db93:aa76:ac37::10."
  type = string
  default = null
}

variable "labels" {
  description = "Add metadata to a pod."
  type = list(string)
  default = null
}

variable "label_file" {
  description = "Read in a line delimited file of labels."
  type = string
  default = null
}

variable "mac_address" {
  description = "Pod network interface MAC address."
  type = string
  default = null
}

variable "name" {
  description = "The name of the pod."
  type = string
}

variable "networks" {
  description = "Set the network mode for the pod. Invalid if using --dns, --dns-opt, or --dns-search with --network that is set to none or container:id."
  type = list(string)
  default = null
}

variable "network_alias" {
  description = "Add a network-scoped alias for the pod, setting the alias for all networks that the pod joins."
  type = string
  default = null
}

variable "no_hosts" {
  description = "Disable creation of /etc/hosts for the pod."
  type = bool
  default = null
}

variable "pid" {
  description = "Set the PID mode for the pod."
  type = string
  default = null
}

variable "pod_id_file" {
  description = "Write the pod ID to the file."
  type = string
  default = null
}

variable "publish" {
  description = "Publish a port or range of ports from the pod to the host."
  type = string
  default = null
}

variable "replace" {
  description = "If another pod with the same name already exists, replace and remove it."
  type = bool
  default = null
}
variable "security_opt" {
  description = "Security options."
  type = string
  default = null
}
variable "share" {
  description = "A comma-separated list of kernel namespaces to share."
  type = string
  default = null
}
variable "share_parent" {
  description = "This boolean determines whether or not all containers entering the pod will use the pod as their cgroup parent."
  type = bool
  default = null
}

variable "sysctls" {
  description = "Configure namespace kernel parameters for all containers in the pod."
  type = list(string)
  default = []
}

variable "userns" {
  description = "Set the user namespace mode for all the containers in a pod."
  type = string
  default = null
}

variable "volumes" {
  description = "Create a bind mount."
  type = list(string)
  default = []
}

variable "volumes_from" {
  description = Mount volumes from the specified container(s).
  type = string
  default = null
}


