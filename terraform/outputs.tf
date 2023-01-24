
output "kubeconfig_path" {
  value = "s3://${module.statestore.bucket}/rke2.yaml"
}

output "rke2" {
  value = module.rke2
}

resource "null_resource" "kubeconfig" {
  provisioner "local-exec" {
    interpreter = ["bash", "-c"]
    command = "aws s3 cp ${module.rke2.kubeconfig_path} rke2.yaml"
  }

  depends_on = [
    module.rke2
  ]
}

