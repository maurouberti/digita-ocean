data "kubernetes_service" "data_service_nginx" {
  metadata {
    name = kubernetes_service.service_nginx.metadata[0].name
  }
}

resource "kubernetes_service" "service_nginx" {
  metadata {
    name = "${var.nome}-nginx-service"
    annotations = {
      "service.beta.kubernetes.io/do-loadbalancer-certificate-id" = digitalocean_certificate.certificate_exemplo.uuid
      "service.beta.kubernetes.io/do-loadbalancer-hostname"       = "${var.domain}"
    }
  }
  spec {
    type = "LoadBalancer"
    selector = {
      app = "${var.nome}-nginx"
    }
    session_affinity = "ClientIP"
    port {
      port        = 443
      target_port = 80
    }
  }
  depends_on = [digitalocean_certificate.certificate_exemplo]
}

resource "kubernetes_deployment" "deployment_nginx" {
  metadata {
    name = "${var.nome}-nginx-deployment"
  }

  spec {
    replicas = 4

    selector {
      match_labels = {
        app = "${var.nome}-nginx"
      }
    }

    template {

      metadata {
        labels = {
          app = "${var.nome}-nginx"
        }
      }

      spec {
        container {
          name  = "nginx"
          image = "nginx:1.21.6"

          #   resources {
          #     limits = {
          #       cpu    = "0.5"
          #       memory = "512Mi"
          #     }
          #     requests = {
          #       cpu    = "250m"
          #       memory = "50Mi"
          #     }
          #   }

          #   liveness_probe {
          #     http_get {
          #       path = "/"
          #       port = 80

          #       http_header {
          #         name  = "X-Custom-Header"
          #         value = "Awesome"
          #       }
          #     }
          #     initial_delay_seconds = 180
          #     period_seconds        = 600
          #   }

        }
      }
    }
  }
}
