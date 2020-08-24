terraform {
    required_providers {
        aws = {
            source = "hashicorp/aws"
        }
    }
}

provider "aws" {
    profile = "default"
    region  = "us-west-1"
}

resource "aws_instance" "example" {
    ami           = "ami-830c94e3"
    instance_type = "t2.micro"
}

#terraform {} block is required so Terraform knows which provider to download from the Terraform Registry


# $ aws configure for aws key prompt; create  ~/.aws/credentials

#provider tells terraform which platform to build infrastructure on

#You can also assign a version to each provider defined in the required_providers block. The version argument is optional, but recommended

#terraform init
#terraform fmt
#terraform validate
#terraform plan
#terraform apply

#terraform show = inspect state

#terraform destroy

resource "aws_eip" "ip" {
    vpc      = true
    instance = aws_instance.exapmle.id
}

# New resource for the S3 bucket our application will use.
resource "aws_s3_bucket" "example" {
  # NOTE: S3 bucket names must be unique across _all_ AWS accounts, so
  # this name must be changed before applying this example to avoid naming
  # conflicts.
  bucket = "terraform-getting-started-guide"
  acl    = "private"
}

# Change the aws_instance we declared earlier to now include "depends_on"
resource "aws_instance" "example" {
  ami           = "ami-830c94e3"
  instance_type = "t2.micro"

  # Tells Terraform that this EC2 instance must be created only after the
  # S3 bucket has been created.
  depends_on = [aws_s3_bucket.example]
}

