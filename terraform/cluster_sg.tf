
resource "aws_security_group" "cluster" {
  name = "${local.uname}-rke2-cluster"
  description = "Shared ${local.uname} cluster security group"
  vpc_id = local.vpc_id
  
  tags = merge({
    "shared" = "true",
  }, local.default_tags, var.tags)
}

resource "aws_security_group_rule" "cluster_shared" {
  description = "Allow all inbound traffic between ${local.uname} cluster nodes"
  from_port = 0
  to_port = 0
  protocol = "-1"
  security_group_id = aws_security_group.cluster.id
  type = "ingress"

  self = true
}

resource "aws_security_group_rule" "cluster_egress" {
  description = "Allow all outbound traffic"
  from_port = 0
  to_port = 0
  protocol = "-1"
  security_group_id = aws_security_group.cluster.id
  type = "egress"

  self = true
}

