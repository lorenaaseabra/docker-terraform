terraform {
  backend "s3" {
    bucket         = "lmvs-gcv-tfstate"
    key            = "terraform/state"
    region         = "ca-central-1"
    encrypt        = true
  }
}