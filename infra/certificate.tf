resource "digitalocean_certificate" "certificate_exemplo" {
  name       = "certificate-${var.nome}"
  type       = "lets_encrypt"
  domains    = ["${var.domain}", "www.${var.domain}"]
  depends_on = [digitalocean_domain.domain_exemplo]
}
