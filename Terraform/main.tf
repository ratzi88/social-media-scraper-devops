provider "aws" {
  region = "eu-central-1"
}

# Call the VPC module
module "vpc" {
  source = "./modules/vpc"

  tags               = var.tags
  availability_zones = ["eu-central-1a", "eu-central-1b"]
}

# Call the Security Groups module
module "security_groups" {
  source = "./modules/security-groups"

  vpc_id = module.vpc.vpc_id
  tags   = var.tags
}

# Call the EKS module
module "eks" {
  source = "./modules/eks"

  vpc_id          = module.vpc.vpc_id
  public_subnets  = module.vpc.public_subnets
  private_subnets = module.vpc.private_subnets
  tags            = var.tags
}

# Call the Instances module (if needed)
module "instances" {
  source          = "./modules/instances"
  private_subnets = module.vpc.private_subnets
  tags            = var.tags
}