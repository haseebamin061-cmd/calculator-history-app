locals {
  project = "calculator-production"

  common_tags = {
    Project     = local.project
    Environment = "production"
    ManagedBy   = "Terraform"
    Application = "calculator-history"
  }
}
