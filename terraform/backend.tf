terraform {
  backend "s3" {
    bucket  = "demo-tfs-state"
    key     = "terraform/terraform.tfstate"
    region  = "eu-west-1"
    encrypt = true
  }
}
