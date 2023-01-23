
resource "aws_security_group" "server" {
  name = "${local.uname}-rke2-server"
  vpc_id = local.vpc_id
  description = "${local.uname} rke2 server node pool"
  tags = merge(local.default_tags, var.tags)
}

resource "aws_security_group_rule" "server_cp" {
  from_port = 6443
  to_port = 6443
  protocol = "tcp"
  security_group_id = aws_security_group.server.id
  type = "ingress"
  source_security_group_id = module.cp_lb.security_group
}

resource "aws_security_group_rule" "server_cp_supervisor" {
  from_port = 9345
  to_port = 9345
  protocol = "tcp"
  security_group_id = aws_security_group.server.id
  type = "ingress"
  source_security_group_id = module.cp_lb.security_group
}

