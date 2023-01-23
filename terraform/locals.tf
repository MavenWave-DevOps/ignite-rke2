
locals {
  uname = var.unique_suffix ? lower("${var.cluster_name}-${random_string.uid.result}") : lower(var.cluster_name)

  default_tags = {
    "ClusterType" = "rke2",
  }

  vpc_id = module.ignite-network.network_id

  subnets = [
    module.ignite-network.private_subnet_id,
    module.ignite-network.failover_private_subnet_id,
  ]

}

