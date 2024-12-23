module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "20.31.6"

  cluster_name    = "social-media-scraper"
  cluster_version = "1.26"
  vpc_id          = var.vpc_id               # Use the variable passed from root
  subnet_ids      = concat(var.public_subnets, var.private_subnets) # Combine subnets

  eks_managed_node_groups = {
    default = {
      desired_capacity = 2
      max_capacity     = 3
      min_capacity     = 1
      instance_types   = ["t2.micro"]
    }
  }

  tags = var.tags
}
