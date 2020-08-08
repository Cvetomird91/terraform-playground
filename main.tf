provider "aws" {
  region  = "us-east-1"
}

resource "tls_private_key" "ubuntu_private_key" {
	algorithm = "RSA"
	rsa_bits  = 4096
}

resource "aws_key_pair" "generated_key" {
	key_name   = "key"
	public_key = "${tls_private_key.ubuntu_private_key.public_key_openssh}"
}

resource "aws_instance" "web" {
	ami 		  = "ami-0ac80df6eff0e70b5"
	instance_type = "t2.micro"
	key_name      = "${aws_key_pair.generated_key.key_name}"

	tags = {
		Name = "Ubuntu1"
	}
}
