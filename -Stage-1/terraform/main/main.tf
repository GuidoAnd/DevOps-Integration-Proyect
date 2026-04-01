data "aws_vpc" "default" {
    default = true
}

data "aws_subnet" "default" {
    vpc_id            = data.aws_vpc.default.id
    availability_zone = var.availability_zone 
    
    filter {
      name = "default-for-az"
      values = ["true"]
    }
}

resource "aws_security_group" "devops_sg" {
    name        = var.sg_name
    description = "Security group for poke-stats app"
    vpc_id      = data.aws_vpc.default.id
    
    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = var.allowed_cidr_blocks
    }

    tags = {
        Name = var.sg_name
    }

}

resource "aws_vpc_security_group_ingress_rule" "allow_ssh_ipv4" {
  security_group_id = aws_security_group.devops_sg.id
  cidr_ipv4         =  "0.0.0.0/0"
  from_port         = var.ssh_port
  ip_protocol       = "tcp"
  to_port           = var.ssh_port  
}

resource "aws_vpc_security_group_ingress_rule" "allow_http_ipv4" {
  security_group_id = aws_security_group.devops_sg.id
  cidr_ipv4         =  "0.0.0.0/0"
  from_port         = var.http_port
  ip_protocol       = "tcp"
  to_port           = var.http_port
}

resource "aws_instance" "app-poke-vm" {
    ami = var.ami
    instance_type = var.instance_type
    subnet_id = data.aws_subnet.default.id

    vpc_security_group_ids = [aws_security_group.devops_sg.id]
    key_name = var.key_a

    #Configuracion IMSV2 requerido
    metadata_options {
      http_endpoint               = "enabled"
      http_tokens                 = "required" 
      http_put_response_hop_limit =  1
    }


    tags = {
        Name        = "${var.environment}-app-poke-instance"
        Environment = var.environment
        ManagedBy   = "terraform"    
    }   
}

output "instance_id" {
    description = "Instance ID"
    value       = aws_instance.app-poke-vm.id
  
}

output "instance_public_ip" {
    description = "Public IP"
    value       = aws_instance.app-poke-vm.public_ip
  
}
output "instance_private_ip" {
    description = "Private IP"
    value       = aws_instance.app-poke-vm.private_ip
  
}

output "instance_public_dns" {
    description = "Public DNS"
    value       = aws_instance.app-poke-vm.public_dns
  
}

output "instance_state" {
    description = "Instance Status"
    value       = aws_instance.app-poke-vm.instance_state
  
}