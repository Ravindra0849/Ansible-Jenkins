variable "cidr_block" {
    type = string
    description = "cidr block for VPC"
}

variable "instance_tenancy" {
    type = string
}

variable "dns_hostnames" {
    type = bool
}

variable "dns_support" {
    type = bool
}

variable "public_cidr" {
    type = string
}

variable "public_ip" {
    type = bool
}

variable "zones" {
    type = string
}

variable "route-cidr" {
    type = string
}

variable "ingress_ports" {
    description = "List of ports to open in the security group"
    type        = list(number)
}

variable "ami" {
    type = string
}

variable "instance_type" {
    type = string
}

variable "key_name" {
    type = string
}

variable "associate_public_ip_address" {
    type = bool
}