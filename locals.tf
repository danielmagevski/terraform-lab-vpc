locals {
  subnet_ids = { for k, v in aws_subnet.this : v.tags.Name => v.id }
      common_tags = {
      Project   = "LAB VPC"
      ManagedBy = "Terraform"
      Owner     = "Daniel Magevski"
  }  
}
