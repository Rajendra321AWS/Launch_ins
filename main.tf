terraform {
  required_version = ">1.1.3"

  required_providers {
    aws = {
      version = ">=2.7.0"
    }
  }
}
provider "aws" {
  region = "us-east-1"
}

data "aws_ami" "ubuntu" {

  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"]
}


resource "aws_instance" "web_server" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t2.micro"

  tags = {
    name = "demo_launch_instance"
  }

}

// terraform ramote state s3
terraform {
  backend "s3" {
    bucket = "allied-raj"
    key    = "myapp/terraform.tfstate"
    region = "us-east-1"
  }
}



