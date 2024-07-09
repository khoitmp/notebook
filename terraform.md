cd <directory_path>

terraform init

terraform plan -var-file="main.tfvars" -out="out.plan"

terraform apply "out.plan"