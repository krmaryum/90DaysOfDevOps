# Region
provider "aws" {
  region = "us-east-2"
}

# Key Pair
resource "aws_key_pair" "my_key_pair" {
  key_name   = "terra-automate-key"
  public_key = file("terra-automate-key.pub")
}

# Default VPC
resource "aws_default_vpc" "default" {
}

# Terraform AWS Security Group and EC2 Configuration

# Security Group
resource "aws_security_group" "my_security_group" {
  name        = "terra-security-group"
  vpc_id      = aws_default_vpc.default.id
  description = "Inbound and outbound rules for the instance security group"
}

# Inbound rule - HTTP (web traffic, e.g. Nginx/Apache)

resource "aws_vpc_security_group_ingress_rule" "allow_http" {
  security_group_id = aws_security_group.my_security_group.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 80
  ip_protocol       = "tcp"
  to_port           = 80
}

# Inbound rule - SSH (remote access)
# Inbound rule - SSH (remote administration - restrict to your IP)

resource "aws_vpc_security_group_ingress_rule" "allow_ssh" {
  security_group_id = aws_security_group.my_security_group.id
  cidr_ipv4         = "0.0.0.0/0"
  # cidr_ipv4         = "YOUR_IP/32"  # Replace with your public IP (restrict to your IP)
  from_port         = 22
  ip_protocol       = "tcp"
  to_port           = 22
}


# Outbound rule - allow all traffic

resource "aws_vpc_security_group_egress_rule" "allow_all_traffic" {
  security_group_id = aws_security_group.my_security_group.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1" # semantically equivalent to all ports
}

# --------------------------------------------------
# EC2 Instance Configuration
# --------------------------------------------------

# EC2 instance - single instance setup


resource "aws_instance" "my_instance" {
  # count                  = 2   # 👈 ADD HERE
  ami                    = "ami-07062e2a343acc423" # OS AMI ID

  instance_type          = "t3.micro" # Instance Type

  key_name               = aws_key_pair.my_key_pair.key_name

  vpc_security_group_ids = [aws_security_group.my_security_group.id]  # VPC & Security Group

  root_block_device {
    volume_size = 10
    volume_type = "gp3"
  }

  tags = {
    Name = "TerraWeek-Modified"
    # Name = "terra-auto-server-${count.index}"  # 👈 update name
  }
}

output "public_ip" {
  value = aws_instance.my_instance.public_ip
}