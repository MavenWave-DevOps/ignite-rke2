
module "iam" {
  count = var.iam_instance_profile == "" ? 1 : 0
  source = "./modules/policies"

  name = "${local.uname}-rke2-server"
  permissions_boundary = var.iam_permissions_boundary
  
  tags = merge({}, local.default_tags, var.tags)
}

