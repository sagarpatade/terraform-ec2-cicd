terraform {
  backend "s3" {
    bucket       = "sagar-terraform-state-2026"
    key          = "dev/terraform.tfstate"
    region       = "ap-south-1"
    encrypt      = true
    use_lockfile = true
  }
}