terraform {
  required_providers {
    null = {
      source  = "hashicorp/null"
      version = "~> 3.0"
    }
  }
}

resource "null_resource" "kind_cluster" {
  provisioner "local-exec" {
    command = "kind create cluster --name devops-cluster --config ../k8s/kind-config.yaml || echo 'Cluster may already exist'"
  }

  provisioner "local-exec" {
    when    = destroy
    command = "kind delete cluster --name devops-cluster"
  }
}

output "cluster_name" {
  value = "devops-cluster"
}
