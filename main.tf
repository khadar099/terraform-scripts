provider "aws" {
  region = "ap-south-1"  # Change as needed
}

resource "aws_instance" "example" {
  count         = 5
  ami           = "ami-0e35ddab05955cf57"  # Amazon Linux 2 AMI (for us-east-1)
  instance_type = "t2.micro"
  key_name      = "key-pair2"         # Replace with your key pair name

  vpc_security_group_ids = [aws_security_group.allow_ssh.id]

  tags = {
    Name = tolist(["app-server", "db-server", "cache-server", "api-server", "frontend-server"])[count.index]
  }
}

resource "aws_security_group" "allow_ssh" {
  name        = "allow_ssh24"
  description = "Allow SSH inbound traffic"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # Restrict to your IP for production
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
