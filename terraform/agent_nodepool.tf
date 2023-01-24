
module "agents" {
  source = "./modules/agent-nodepool"
  count = var.use_rke2 ? 1 : 0

  name    = "generic"
  vpc_id  = local.vpc_id
  subnets = local.subnets

  ami                 = data.aws_ami.rhel8.image_id
  ssh_authorized_keys = [tls_private_key.ssh.public_key_openssh]
  spot                = true
  asg                 = { min : 1, max : 5, desired : 2 }
  instance_type       = "t3a.medium"

  cluster_data = local.cluster_data

  tags = local.tags
}

