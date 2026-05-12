# This is a simple variable of type map

variable "instances" {
  description = "Map of instance names to AMI IDs, SSH users, and OS family"

  type = map(object({
    ami           = string
    user          = string
    os_family     = string
    instance_type = string
  }))

  # Default values for instances
  default = {
    #"master-ubuntu" = {
    #ami       = "ami-07062e2a343acc423" # Ubuntu Server 24.04 LTS (HVM)
    #user      = "ubuntu"
    #os_family = "ubuntu"
    #}

    "worker-ubuntu" = {
      ami           = "ami-07062e2a343acc423" # Ubuntu Server 24.04 LTS (HVM)
      user          = "ubuntu"
      os_family     = "ubuntu"
      instance_type = "t3.micro"
    }

    "worker-redhat" = {
      ami           = "ami-0a951f007be151ff9" # Red Hat Enterprise Linux 10 (HVM)
      user          = "ec2-user"
      os_family     = "redhat"
      instance_type = "t3.micro"
    }

    "worker-amazon" = {
      ami           = "ami-0a1b6a02658659c2a" # Amazon Linux 2023
      user          = "ec2-user"
      os_family     = "amazon"
      instance_type = "t3.micro"
    }
  }
}

# ================================
# Instance Power Control Variable
# ================================

variable "instance_state" {
  description = "Control EC2 instance state (running or stopped)"
  type        = string
  default     = "running"
}
