resource "digitalocean_ssh_key" "ssh_key_exemplo" {
  name       = "ssh_key.${var.nome}.pub"
  public_key = var.ssh_key
}
