variable "sg_name" {
    description = "Security group name"
    type = string
}

variable "instance_name" {
    description = "Instance name"
    type = string
}

variable "environment" {
    description = "Environment name" 
    type = string
}

variable "allowed_cidr_blocks" {
    description = "value"
    type = list(string)    
}

variable "ami" {
    description = "Image"
    type = string    
}

variable "ssh_port" {
    description = "Port"
    type = number 
}
variable "http_port" {
    description = "Port"
    type = number
}

variable "key_a" {
    description = "OpenSSh access key"
    type = string    
}

variable "instance_type" {
    description = "Tipo de instancia"
    type = string
}
variable "availability_zone" {
    description = "Zona de disponibilidad"
    type = string
}