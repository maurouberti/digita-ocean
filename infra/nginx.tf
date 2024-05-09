data "kubernetes_service" "data_service_nginx" {
  metadata {
    name = kubernetes_service.service_nginx.metadata[0].name
  }
}

resource "kubernetes_service" "service_nginx" {
  metadata {
    name = "service-nginx"
  }
  spec {
    selector = {
      ref = "nginx"
    }
    session_affinity = "ClientIP"
    port {
      port        = 80
      target_port = 80
    }
    type = "LoadBalancer"
  }
}

resource "kubernetes_deployment" "deployment_nginx" {
  metadata {
    name = "deployment-nginx"
    labels = {
      ref = "nginx"
    }
  }

  spec {
    replicas = 4

    selector {
      match_labels = {
        ref = "nginx"
      }
    }

    template {

      metadata {
        labels = {
          ref = "nginx"
        }
      }

      spec {
        container {
          image = "nginx:1.21.6"
          name  = "nginx"

          resources {
            limits = {
              cpu    = "0.5"
              memory = "512Mi"
            }
            requests = {
              cpu    = "250m"
              memory = "50Mi"
            }
          }

          liveness_probe {
            http_get {
              path = "/"
              port = 80

              http_header {
                name  = "X-Custom-Header"
                value = "Awesome"
              }
            }
            initial_delay_seconds = 180
            period_seconds        = 600
          }

        }
      }
    }
  }
}
