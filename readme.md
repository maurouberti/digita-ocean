![Static Badge](https://img.shields.io/badge/terraform-v1.8.0-%235c4ee5)
![Static Badge](https://img.shields.io/badge/digitaocean-2.0-blue)
![Static Badge](https://img.shields.io/badge/kubernetes-1.29.1--do.1-%23326ce5)

# DigitalOcean

Terraform na DigitalOcean provisionando um cluster Kubernetes.

## Criar INFRA

### ssh

```
$ ssh-keygen -t rsa -C "maurouberti@hotmail.com" -f ./tokens/tf-digitalocean-exemplo
```

### terraform

```
$ terraform init
$ terraform apply
```

### usar **kubectl**

Caso o arquivo `~/.kube/config` não tenha sido criado na pasta do usuário, copiar ele na pasta do usuario para funcionar os comandos kubectl no **cluster**.

```
$ kubectl config get-clusters
```

## Excluir INFRA

```
$ terraform destroy
$ rm -f ./tokens/tf-digitalocean-exemplo ./tokens/tf-digitalocean-exemplo.pub
$ rm ~/.kube/config
$ rm -rf .terraform && rm terraform.tfstate && rm .terraform.lock.hcl
```
