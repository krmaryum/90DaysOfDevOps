# Region

provider "aws" {

  region = "us-east-2"

}

# Key Value pair

resource "aws_key_pair" "my_key_pair" {

  key_name   = "terra-automate-key"
  public_key = file("terra-automate-key.pub")
}

# VPC Default

resource "aws_default_vpc" "default" {
}

# Terraform AWS Security Group and EC2 Configuration

# Security Group 

resource "aws_security_group" "my_security_group" {
  name        = "terra-security-group"
  vpc_id      = aws_default_vpc.default.id # interpolation
  description = "this is Inbound and outbound rules for EC2 instances Security group"

}

# ====================================================
# Inbound & Outbount port rules

# Inbound rule - HTTP (web traffic, e.g. Nginx/Apache)
#=====================================================

resource "aws_vpc_security_group_ingress_rule" "allow_http" {
  security_group_id = aws_security_group.my_security_group.id
  cidr_ipv4         = "0.0.0.0/0" # That means HTTP is open to the entire internet
  from_port         = 80
  ip_protocol       = "tcp"
  to_port           = 80
}

# ================================================================
# Inbound rule - SSH (remote access)
# Inbound rule - SSH (remote administration - restrict to your IP)
# ================================================================

resource "aws_vpc_security_group_ingress_rule" "allow_ssh" {
  security_group_id = aws_security_group.my_security_group.id
  cidr_ipv4         = "0.0.0.0/0" # That means SSH is open to the entire internet
  # # cidr_ipv4         = "YOUR_IP/32"  # Replace with your public IP (restrict to your IP)
  from_port   = 22
  ip_protocol = "tcp"
  to_port     = 22
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

# EC2 instance - multi instances setup

resource "aws_instance" "my_instance" {

  # count = 3 # uses when we need to use same machines

  for_each = var.instances # 4 instances

  ami           = each.value.ami                    # iterate through each instance and gives its ami value (OS AMI ID)
  instance_type = each.value.instance_type          # Instance Type
  key_name      = aws_key_pair.my_key_pair.key_name # Key pair

  vpc_security_group_ids = [aws_security_group.my_security_group.id] # VPC & Security Group

  # root storage (EBS)
  root_block_device {
    volume_size = 10
    volume_type = "gp3"
  }

  tags = {
    Name      = each.key
    os_family = each.value.os_family
  }
}

# ===================================================
# Output all public IPs
# ===================================================

output "public_ips" {
  value = {
    for name, instance in aws_instance.my_instance :
    name => instance.public_ip
  }
}
