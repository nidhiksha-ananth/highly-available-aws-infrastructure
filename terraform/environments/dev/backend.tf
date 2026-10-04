terraform {
  backend "s3" {
    bucket       = "highly-available-aws-terraform-state-nidhiksha"
    key          = "highly-available-aws-infrastructure/terraform.tfstate"
    region       = "ap-south-1"
    encrypt      = true
    use_lockfile = true
  }
}