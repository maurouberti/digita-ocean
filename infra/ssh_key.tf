resource "digitalocean_ssh_key" "ssh_key_exemplo" {
  name       = "id_rsa-exemplo.pub"
  public_key = var.ssh_key
}
