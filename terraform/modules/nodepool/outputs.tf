
output "launch_template_id" {
  value = aws_launch_template.template.id
}

output "launch_template_name" {
  value = aws_launch_template.template.name
}

output "asg_id" {
  value = aws_autoscaling_group.asg.id
}

output "asg_name" {
  value = aws_autoscaling_group.asg.name
}

output "asg_arn" {
  value = aws_autoscaling_group.asg.arn
}

output "security_group" {
  value = aws_security_group.sg.id
}

