provider "aws" {
  region  = "us-east-1"
}

locals {
	aws_key = "aws_key"
}

resource "tls_private_key" "ubuntu_private_key" {
	algorithm = "RSA"
	rsa_bits  = 4096
}

resource "aws_key_pair" "generated_key" {
	key_name   = local.aws_key
	public_key = "${tls_private_key.ubuntu_private_key.public_key_openssh}"
}

resource "aws_vpc" "first-vps" {
	cidr_block = "10.0.0.0/16"
	tags = {
		Name = "production"
	}
}

resource "aws_subnet" "subnet1" {
  vpc_id     = aws_vpc.first-vps.id
  cidr_block = "10.0.1.0/24"

  tags = {
    Name = "prod-subnet"
  }
}

# resource "aws_instance" "web" {
# 	ami 		  = "ami-0ac80df6eff0e70b5"
#	instance_type = "t2.micro"
#	key_name      = "${aws_key_pair.generated_key.key_name}"
#
#	tags = {
#		Name = "Ubuntu"
#	}
# }
