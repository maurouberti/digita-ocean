module "module_exemplo" {
  source       = "./infra"
  do_token     = file("./tokens/digital_ocean_api_token")
  ssh_key      = file("./tokens/tf-digitalocean-exemplo.pub")
  domain       = "sane-maquiagem.com.br"
  droplet_size = "s-2vcpu-2gb"
  region       = "nyc3"
}

output "ip_address" {
  value       = module.module_exemplo.ip_address_lb
  description = "IP externo do loadbalancer."
}
