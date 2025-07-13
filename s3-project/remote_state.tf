data "terraform_remote_state" "ec2" {
  backend = "s3"
  config = {
    bucket = "tf-state-dev-project"
    key    = "ec2/terraform.tfstate"
    region = "us-east-1"
  }
}
