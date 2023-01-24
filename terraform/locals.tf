
locals {
  uname = var.unique_suffix ? lower("${var.cluster_name}-${random_string.uid.result}") : lower(var.cluster_name)

  default_tags = {
    "ClusterType" = "rke2",
  }

  vpc_id = module.ignite-network.network_id

  subnets = [
    module.ignite-network.private_subnet_id,
  ]

  ccm_tags = {
    "kubernetes.io/cluster/${local.uname}" = "owned"
  }

  cluster_data = {
    name       = local.uname
    server_url = module.cp_lb.dns
    cluster_sg = aws_security_group.cluster.id
    token      = module.statestore.token
  }

  tags = {}
}

