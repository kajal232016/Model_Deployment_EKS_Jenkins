terraform {
  backend "s3" {
    bucket = "<AWS_BUCKET>"
    region = "<AWS_REGION>"
    key = "eks-server/terraform.tfstate"
  }
}