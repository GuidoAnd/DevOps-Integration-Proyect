terraform {
  backend "s3" {
    bucket = "devops-pi-bucket-025889067332-us-east-1-an"
    key = "jenkins/terraform.tfstate"
    region = "us-east-1"    
  }
}