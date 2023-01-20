
module "ignite-network" {
  source = "app.terraform.io/fosterm-mw/ignite-network/aws"
  vpc_name = "rke2-network"
}

