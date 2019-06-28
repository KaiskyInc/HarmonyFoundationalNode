# Harmond Foundational Node
Deployment script for Harmony Foundational Node on AWS. Detailed Manual Setup Guide can be found [here](https://docs.google.com/document/d/1t4TCcvqu84YK5657ddOrezJc_Dn8GRiIwGMwPGlk6x8)

## Prerequisites
- Install [Terraform](https://learn.hashicorp.com/terraform/getting-started/install.html)
    - On MacOS with Homebrew, run: `brew install terraform`
- Create AWS S3 bucket if one does not already exist
- Update `terraform/provider.tf` with your bucket name
- Existing AWS Key Pair
    - If you don't have an existing one, create one locally by running `ssh-keygen` (MacOS) and follow the steps. Uncomment out the `aws_key_pair` resource in `terraform/main.tf` and copy the content of generated `.pub` file into `public_key` field.

## Deployment
Before deploying the instance, review `terraform/variables.tf` and adjust to your own configurations. The script will spin up an EC2 instance within a new VPC in your AWS account. To deploy, run:
```
cd terraform
terraform init
terraform plan -out=plan.out
# Review the plan output, confirm the change is what you expect
terraform apply plan.out
```

## Setup
```
# Copy setup script into your instance
scp -i $YOUR_IDENTITY_FILE scripts/setup.sh ubuntu@$YOUR_IP:~

# SSH into your instance
ssh -i $YOUR_IDENTITY_FILE ubuntu@$YOUR_IP

# Run setup script
chmod u+x setup.sh
./setup.sh

# Create new key pair
./wallet.sh new

# Create BLS key
./wallet.sh blsgen
```

## TODO
- Setup auto provisioning
