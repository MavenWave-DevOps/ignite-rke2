
variable "region" {
  default = "us-west-1"
  type = string
}

variable "tags" {
  description = "Map of tags to all resources created"
  default     = {}
  type        = map(string)
}

variable "unique_suffix" {
  description = "Enables/disables generation of a unique suffix to cluster name"
  type        = bool
  default     = true
}

variable "cluster_name" {
  description = "Name of the rkegov cluster to be created"
  type        = string
  default     = "ignite-rke2"
}

variable "controlplane_enable_cross_zone_load_balancing" {
  description = "Toggle between controlplane cross zone load balancing"
  default     = true
  type        = bool
}

variable "controlplane_internal" {
  description = "Toggle between public or private control plane load balancer"
  default     = true
  type        = bool
}

variable "controlplane_access_logs_bucket" {
  description = "Bucket name for logging requests to control plane load balancer"
  type        = string
  default     = "disabled"
}

variable "controlplane_allowed_cidrs" {
  description = "Server pool security group allowed cidr ranges"
  type        = list(string)
  default     = ["0.0.0.0/0"]
}

variable "iam_instance_profile" {
  description = "Profile for k8s access to be created"
  type = string
  default = null
}

variable "iam_permissions_boundary" {
  description = "Server pool block device mapping configuration"
  type = map(string)
  default = {
    "size" = 30
    "encrypted" = false
  }
}



