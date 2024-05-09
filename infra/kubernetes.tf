data "digitalocean_kubernetes_versions" "k8s_versions_exemplo" {
  version_prefix = "1.29."
}

resource "digitalocean_kubernetes_cluster" "k8s_cluster_exemplo" {
  name    = "cluster-exemplo"
  region  = var.region
  version = data.digitalocean_kubernetes_versions.k8s_versions_exemplo.latest_version
  tags    = ["cluster-exemplo", "kubernetes-cluster"]

  node_pool {
    name       = "node-exemplo"
    size       = var.droplet_size
    auto_scale = true
    min_nodes  = 1
    max_nodes  = 3
    tags       = ["kubernetes", "k8s"]
  }
}

data "digitalocean_kubernetes_cluster" "data_k8s_cluster_exemplo" {
  name = digitalocean_kubernetes_cluster.k8s_cluster_exemplo.name
}

provider "kubernetes" {
  host  = data.digitalocean_kubernetes_cluster.data_k8s_cluster_exemplo.endpoint
  token = data.digitalocean_kubernetes_cluster.data_k8s_cluster_exemplo.kube_config[0].token
  cluster_ca_certificate = base64decode(
    data.digitalocean_kubernetes_cluster.data_k8s_cluster_exemplo.kube_config[0].cluster_ca_certificate
  )
}
