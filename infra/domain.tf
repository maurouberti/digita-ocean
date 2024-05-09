resource "digitalocean_domain" "domain_exemplo" {
  name       = var.domain
  ip_address = data.kubernetes_service.data_service_nginx.status.0.load_balancer.0.ingress.0.ip
}

resource "digitalocean_record" "CNAME_exemplo" {
  domain = digitalocean_domain.domain_exemplo.name
  type   = "CNAME"
  name   = "www"
  value  = "@"
}

output "ip_address_lb" {
  value       = data.kubernetes_service.data_service_nginx.status.0.load_balancer.0.ingress.0.ip
  description = "IP externo do loadbalancer."
}
