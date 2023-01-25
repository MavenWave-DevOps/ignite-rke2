
# data "aws_ami" "rhel8" {
#   most_recent = true
#   # owners = ["219670896067"]
#
#   filter {
#     name   = "name"
#     values = ["RHEL-8*"]
#   }
#
#   filter {
#     name   = "architecture"
#     values = ["x86_64"]
#   }
# }

resource "tls_private_key" "ssh" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "local_file" "ssh_pem" {
  filename        = "${var.cluster_name}.pem"
  content         = tls_private_key.ssh.private_key_pem
  file_permission = "0600"
}

module "rke2" {
  source = "./modules/nodepool"
  count = var.use_rke2 ? 1 : 0
  name   = "${local.uname}-server"

  vpc_id  = local.vpc_id
  subnets = local.subnets

  ami                       = data.aws_ami.ubuntu.image_id
  instance_type             = var.instance_type
  block_device_mappings     = var.block_device_mappings
  vpc_security_group_ids    = concat([aws_security_group.server.id, aws_security_group.cluster.id], var.extra_security_group_ids)
  spot                      = var.spot
  load_balancers            = [module.cp_lb.name]
  wait_for_capacity_timeout = var.wait_for_capacity_timeout
  # ssh_authorized_keys = [tls_private_key.ssh.public_key_openssh]
  # controlplane_internal = false

  userdata             = data.template_cloudinit_config.config.rendered
  iam_instance_profile = var.iam_instance_profile == "" ? module.iam[0].iam_instance_profile : var.iam_instance_profile

  asg = { min : 1, max : 5, desired : var.servers }

  min_elb_capacity = 0

  tags = merge({
    "Role" = "server"
  }, local.ccm_tags, var.tags)
}

# module "rke2" {
#   source = "./modules/nodepool"
#   name = "${local.uname}-server"
#
#   vpc_id = local.vpc_id
#   subnets = local.subnets
#
#   ami = data.aws_ami.rhel8.image_id
#   ssh_authorized_keys = [tls_private_key.ssh.public_key_openssh]
#   instance_type = "t3a.medium"
#   controlplane_internal = false
#   servers = 1
#
#   enable_ccm = true
#
#   rke2_config = <<-EOT
# node-label:
#   - "name=server"
#   - "os=rhel8"
# EOT
#   
#   tags = local.tags
# }
#
# output "rke2" {
#   value = module.rke2
# }
#
# resource "null_resource" "kubeconfig" {
#   provisioner "local-exec" {
#     interpreter = ["bash", "-c"]
#     command = "aws s3 cp ${module.rke2.kubeconfig_path} rke2.yaml"
#   }
#
#   depends_on = [
#     module.rke2
#   ]
# }
#
