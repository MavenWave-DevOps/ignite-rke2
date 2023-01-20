
module "cp_lb" {
  source  = "./modules/elb"
  vpc_id  = locals.vpc_id
  subnets = locals.subnets

  enable_cross_zone_load_balancing = var.controlplane_enable_cross_zone_load_balancing
  internal                         = var.controlplane_internal
  access_logs_bucket               = var.controlplane_access_logs_bucket

  cp_ingress_cidr_blocks            = var.controlplane_allowed_cidrs
  cp_supervisor_ingress_cidr_blocks = var.controlplane_allowed_cidrs

  tags = merge({}, local.default_tags, local.default_tags, var.tags)
}

