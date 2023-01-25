# resource "null_resource" "kubeconfig" {
#   provisioner "local-exec" {
#     interpreter = ["bash", "-c"]
#     command = "aws s3 cp s3://ignite-rke2-k4j-rke2/rke2.yaml rke2.yaml"
#   }
#
#   depends_on = [
#     module.rke2
#   ]
# }
#
