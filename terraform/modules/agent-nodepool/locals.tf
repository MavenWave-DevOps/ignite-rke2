
locals {
  name = "${var.cluster_data.name}-${var.name}"

  default_tags = {
    "ClusterType" = "rke2",
  }

  ccm_tags = {
    "kubernetes.io/cluster/${var.cluster_data.name}" = "owned",
  }

  autoscaler_tags = {
    "k8s.io/cluster-autoscaler/enabled"                  = var.enable_autoscaler,
    "k8s.io/cluster-autoscaler/${var.cluster_data.name}" = var.enable_autoscaler,
  }
}

