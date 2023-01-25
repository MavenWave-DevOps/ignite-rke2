
resource "local_file" "yaml" {
  content = ""
  filename = "${path.module}/rke2.yaml"
}

resource "null_resource" "kubeconfig" {
  provisioner "local-exec" {
    interpreter = ["bash", "-c"]
    command = "aws s3 cp s3://ignite-rke2-k4j-rke2/rke2.yaml rke2.yaml"
  }

  depends_on = [
    module.rke2
  ]
}

#
#
#
# resource "aws_security_group_rule" "quickstart_ssh" {
#   from_port         = 22
#   to_port           = 22
#   protocol          = "tcp"
#   security_group_id = local.cluster_data.cluster_sg
#   type              = "ingress"
#   cidr_blocks       = ["0.0.0.0/0"]
# }
#
