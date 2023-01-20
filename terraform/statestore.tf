
resource "random_password" "token" {
  length  = 40
  special = false
}

resource "random_string" "uid" {
  length  = 3
  special = false
  lower   = true
  upper   = false
  number  = true
}

module "statestore" {
  source = "./modules/statestore"
  name   = local.uname
  token  = random_password.token.result
  tags   = merge(local.default_tags, var.tags)
}

