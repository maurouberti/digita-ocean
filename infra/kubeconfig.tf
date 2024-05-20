resource "local_file" "kubeconfig" {
  filename   = "~/.kube/config"
  content    = data.digitalocean_kubernetes_cluster.data_k8s_cluster_exemplo.kube_config.0.raw_config
  depends_on = [digitalocean_kubernetes_cluster.k8s_cluster_exemplo]
}
