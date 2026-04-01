variable "sg_name" {
    description = "Nombre del grupo de seguridad"
    type = string
}

variable "environment" {
    description = "Nombre del entorno"
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
    description = "LLave de accesso a SSH"
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