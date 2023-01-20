
locals {
  uname = var.unique_suffix ? lower("${var.cluster_name}-${random_string.uid.result}") : lower(var.cluster_name)
  
  default_tags = {
    "ClusterType" = "rke2",
  }

  vpc_id = ignite-network.id

  subnets = [
    ignite-network.private_subnet_id,
    ignite-network.failover_private_subnet_id,
  ]

}

