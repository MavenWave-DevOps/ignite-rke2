
output "kubeconfig_path" {
  value = "s3://${module.statestore.bucket}/rke2.yaml"
}

# output "kubeconfig" {
#   value = resource.null_resource.kubeconfig
# }
#
# output "rke2" {
#   value = module.rke2
# }
#
# resource "null_resource" "kubeconfig" {
#   provisioner "local-exec" {
#     interpreter = ["bash", "-c"]
#     command = "aws s3 cp s3://${module.statestore.bucket}/rke2.yaml rke2.yaml"
#   }
#
#   depends_on = [
#     module.rke2
#   ]
# }
#
