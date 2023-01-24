
output "kubeconfig_path" {
  value = "s3://${module.statestore.bucket}/rke2.yaml"
}

