
output "security_group" {
  value = module.nodepool.security_group
}

output "nodepool_name" {
  value = module.nodepool.asg_name
}

output "nodepool_id" {
  value = module.nodepool.asg_id
}

output "nodepool_arn" {
  value = module.nodepool.asg_arn
}

output "iam_role" {
  value = var.iam_instance_profile == "" ? module.iam[0].role : var.iam_instance_profile
}

output "iam_instance_profile" {
  value = var.iam_instance_profile == "" ? module.iam[0].iam_instance_profile : var.iam_instance_profile
}

output "iam_role_arn" {
  value = var.iam_instance_profile == "" ? module.iam[0].role_arn : var.iam_instance_profile
}

