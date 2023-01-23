
module "iam" {
  count  = var.iam_instance_profile == "" ? 1 : 0
  source = "./modules/policies"

  name                 = "${local.uname}-rke2-server"
  permissions_boundary = var.iam_permissions_boundary

  tags = merge({}, local.default_tags, var.tags)
}

resource "aws_iam_role_policy" "aws_required" {
  count = var.iam_instance_profile == "" ? 1 : 0
  
  name = "${local.uname}-rke2-server-aws-introspect"
  role = module.iam[count.index].role
  policy = data.aws_iam_policy_document.aws_required[count.index].json
}

resource "aws_iam_role_policy" "aws_ccm" {
  count = var.iam_instance_profile == "" ? 1 : 0
  
  name = "${local.uname}-rke2-server-aws-ccm"
  role = module.iam[count.index].role
  policy = data.aws_iam_policy_document.aws_ccm[count.index].json
}

resource "aws_iam_role_policy" "get_token" {
  count = var.iam_instance_profile == "" ? 1 : 0
  
  name = "${local.uname}-rke2-server-get-token"
  role = module.iam[count.index].role
  policy = data.statestore.token.policy_document
}

resource "aws_iam_role_policy" "put_kubeconfig" {
  count = var.iam_instance_profile == "" ? 1 : 0
  
  name = "${local.uname}-rke2-server-put-kubeconfig"
  role = module.iam[count.index].role
  policy = data.statestore.kubeconfig_put_policy
}

