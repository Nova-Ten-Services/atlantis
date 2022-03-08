terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.57"
    }
  }

  required_version = ">= 1.0" // Version of Terraform itself, not aws provider.
}

provider "aws" {
  profile = "default"
  region  = "ap-southeast-1"
}

resource "aws_instance" "terraform-alpha" {
  ami                    = "ami-082105f875acab993"
  instance_type          = "t3a.micro"
  subnet_id              = "subnet-055a68bb4f8034600"
  vpc_security_group_ids = ["sg-069a9aa8c2a00931f", "sg-0484b52a2335faf59"]
  key_name               = "orchard-admin-202011"
  tags = {
    Name = "Terraform Alpha"
  }
}
