
output "iam_instance_profile" {
  value = aws_iam_instance_profile.profile.name
}

output "role" {
  value = aws_iam_role.role.name
}

output "role_arn" {
  value = aws_iam_role.role.arn
}

