resource "aws_instance" "my_ec2_node" {
	ami					= "ami-0c92dfd5a597f1e61"	# Centos 8 Base Image
	instance_type		= "t2.micro"				# Memory 1 GB / vCPU 1 Core
	key_name            	= aws_key_pair.ec2_admin_key.key_name
  availability_zone = "ap-northeast-2a"

	associate_public_ip_address	= true				# assign a Public IP

	# include VPC Security Group
	vpc_security_group_ids = [
		aws_security_group.allow_SSH.id
	]

	tags = {
		Name = "Centos-8 Node"
	}
}

# 방화벽 22번 포트 오픈
resource "aws_security_group" "allow_SSH" {
  name = "allow_ssh_from_all"
  description = "Allow SSH port from all"

  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    cidr_blocks = [ "0.0.0.0/0"]
    from_port = 0
    protocol = "-1"
    to_port = 0
  }
}
