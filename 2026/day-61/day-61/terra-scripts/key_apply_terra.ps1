$ErrorActionPreference = "Stop"

$keyName = "terra-automate-key"

ssh-keygen -t ed25519 -f ".\$keyName" -C "terraform-key"

terraform init
terraform validate
terraform plan
terraform apply -auto-approve

$publicIp = (terraform output -raw public_ip)

ssh -i ".\$keyName" "ubuntu@$publicIp"

echo -e "terra-automate-key\n*.tfstate\n*.tfstate.backup" >> .gitignore
