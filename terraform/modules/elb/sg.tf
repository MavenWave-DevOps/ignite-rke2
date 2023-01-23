
resource "aws_security_group" "controlplane" {
  name        = var.controlplane_name
  description = "${var.controlplane_name} security group"
  vpc_id      = var.vpc_id

  tags = merge({}, var.tags)
}

