provider "aws" {
  profile = "default"
  region  = "us-west-2"
}

variable "key_name" {}

resource "tls_private_key" "example" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "generated_key" {
  key_name   = var.key_name
  public_key = tls_private_key.example.public_key_openssh
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

  owners = ["099720109477"] # Canonical



}

output "test" {
  value = data.aws_ami.ubuntu
}

resource "aws_instance" "app_server" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t2.micro"
  key_name      = aws_key_pair.generated_key.key_name

  iam_instance_profile = "${aws_iam_instance_profile.test_profile.name}"


  tags = {
    Name = "Flugel"
    Owner = "InfraTeam"
  }
}



resource "aws_s3_bucket" "b" {
  bucket = "gabkings"
  acl    = "private"

  tags = {
    Name = "Flugel"
    Owner = "InfraTeam"
    Environment = "Dev"
  }

    cors_rule {
    allowed_headers = ["*"]
    allowed_methods = ["PUT", "POST", "GET"]
    allowed_origins = ["https://s3-website-test.hashicorp.com"]
    expose_headers  = ["ETag"]
    max_age_seconds = 3000
  }
}

