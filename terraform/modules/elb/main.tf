
resource "aws_security_group" "controlplane" {
  name        = var.controlplane_name
  description = "${var.controlplane_name} security group"
  vpc_id      = var.vpc_id

  tags = merge({}, var.tags)
}

resource "aws_security_group_rule" "apiserver" {
  from_port         = var.cp_port
  to_port           = var.cp_port
  protocol          = "tcp"
  security_group_id = aws_security_group.conrtolplane.id
  type              = "ingress"

  cidr_blocks = var.cp_ingress_cidr_blocks

  depends_on = [
    resource.aws_security_group.controlplane,
  ]
}

resource "aws_security_group_rule" "supervisor" {
  from_port         = var.cp_supervisor_port
  to_port           = var.cp_supervisor_port
  protocol          = "tcp"
  security_group_id = aws_security_group.conrtolplane.id
  type              = "ingress"

  cidr_blocks = var.cp_supervisor_ingress_cidr_blocks

  depends_on = [
    resource.aws_security_group.controlplane,
  ]
}

resource "aws_security_group_rule" "egress" {
  from_port         = "0"
  to_port           = "0"
  protocol          = "-1"
  security_group_id = aws_security_group.conrtolplane.id
  type              = "egress"

  cidr_blocks = ["0.0.0.0/0"]

  depends_on = [
    resource.aws_security_group.controlplane,
  ]
}

resource "aws_elb" "controlplane" {
  name = var.controlplane_name

  internal        = var.internal
  subnets         = var.subnets
  security_groups = [aws_security_group.controlplane.id]

  cross_zone_load_balancing = var.enable_cross_zone_load_balancing

  listener {
    instance_port     = var.cp_port
    instance_protocol = "TCP"
    lb_port           = var.cp_port
    lb_protocol       = "TCP"
  }

  listener {
    instance_port     = var.cp_supervisor_port
    instance_protocol = "TCP"
    lb_port           = var.cp_supervisor_port
    lb_protocol       = "TCP"
  }

  health_check {
    healthy_threshold   = 3
    interval            = 10
    target              = "TCP:${var.cp_port}"
    timeout             = 3
    unhealthy_threshold = 3
  }

  access_logs {
    bucket  = var.access_logs_bucket
    enabled = var.access_logs_bucket != "disabled"
  }

  tags = merge({}, var.tags)

  depends_on = [
    resource.aws_security_group.controlplane,
  ]
}

