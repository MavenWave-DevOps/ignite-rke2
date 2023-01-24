
variable "name" {
  description = "Nodepool name"
  type        = string
}

variable "vpc_id" {
  description = "VPC of cluster"
  type        = string
}

variable "subnets" {
  description = "List of subnets IDs to create resources in"
  type        = list(string)
}

variable "instance_type" {
  description = "Node pool instance type"
  default     = "t3.nano"
}

variable "ami" {
  description = "Node pool ami"
  type        = string
  default     = ""
}

variable "tags" {
  description = "Map of additional tags to add to all resources created"
  type        = map(string)
  default     = {}
}

variable "iam_instance_profile" {
  description = "Node pool IAM Instance Profile, created if left blank (default behavior)"
  type        = string
  default     = ""
}

variable "block_device_mappings" {
  description = "Node pool list of public keys to add as authorized ssh keys, not required"
  type        = map(string)
  default = {
    "size" = 30
    type   = "gp2"
  }
}

variable "ssh_authorized_keys" {
  description = "Node pool block device mapping configuration"
  type        = list(string)
  default     = []
}

variable "asg" {
  description = "Node pool AutoScalingGroup scaling definition"
  type = object({
    min     = number
    max     = number
    desired = number
  })

  default = {
    min     = 1
    max     = 5
    desired = 1
  }
}

variable "spot" {
  description = "Toggle spot requests for node pool"
  type        = bool
  default     = false
}

variable "extra_security_group_ids" {
  description = "List of additional security group IDs"
  type        = list(string)
  default     = []
}

variable "cluster_data" {
  description = "Required data relevant to joining an existing rke2 cluster, sourced from main rke2 module, do NOT modify"
  type = object({
    name       = string
    server_url = string
    cluster_sg = string
    token = object({
      bucket          = string
      bucket_arn      = string
      object          = string
      policy_document = string
    })
  })
}

variable "rke2_version" {
  description = "Version to use for RKE2 server nodepool"
  type        = string
  default     = "v1.19.7+rke2r1"
}

variable "rke2_config" {
  description = "Node pool additional configuration passed as rke2 config file"
  default     = ""
}

variable "enable_ccm" {
  description = "Toggle enabling the cluster as aws aware, this will ensure the appropriate IAM policies are present"
  type        = bool
  default     = false
}

variable "enable_autoscaler" {
  description = "Toggle configure the nodepool for cluster autoscaler, this will ensure the appropriate IAM policies are present"
  type        = bool
  default     = true
}

variable "download" {
  description = "Toggle best effort download of rke2 dependencies"
  type        = bool
  default     = true
}

variable "pre_userdata" {
  description = "Custom userdata to run immediately before rke2 node attempts to join cluster"
  type        = string
  default     = ""
}

variable "wait_for_capacity_timeout" {
  description = "How long Terraform should wait for ASG instances to be healthy before timing out."
  type        = string
  default     = "10m"
}

variable "post_userdata" {
  description = "Custom userdata to run immediately after rke2 node attempts to join cluster"
  type        = string
  default     = ""
}

variable "iam_permissions_boundary" {
  description = "If provided, the IAM role created for the nodepool will be created with this permissions boundary attached."
  type        = string
  default     = null
}

variable "extra_block_device_mappings" {
  description = "Used to specify additional block device mapping configs"
  type        = list(map(string))
  default = [
  ]
}

