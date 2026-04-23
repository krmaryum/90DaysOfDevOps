# Terraform .gitignore (Safe for GitHub)

# Terraform files
.terraform/
*.tfstate
*.tfstate.*
crash.log

# Sensitive data
*.tfvars
*.tfvars.json

# SSH keys (VERY IMPORTANT)
terra-automate-key
terra-automate-key.pub
*.pem
*.key

# Local override files
override.tf
override.tf.json
*_override.tf
*_override.tf.json

# CLI configuration files
.terraformrc
terraform.rc

# Optional local files
variables
*.backup
