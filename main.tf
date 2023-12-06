
# Create an VPC for Jenkins Server

resource "aws_vpc" "VPC" {
    cidr_block = var.cidr_block
    instance_tenancy = var.instance_tenancy
    enable_dns_hostnames = var.dns_hostnames
    enable_dns_support = var.dns_support

    tags = {
        Name = "Jenkins-Vpc"
        Terraform = "true"
    }
}


# Create a Public Subnet

resource "aws_subnet" "Public" {
    cidr_block = var.public_cidr
    vpc_id = aws_vpc.VPC.id
    map_public_ip_on_launch = var.public_ip
    availability_zone = var.zones

    tags = {
        Name = "Jenkins-public-subnet"
        Terraform = "true"
    }
}


# Create an Internet Gateway

resource "aws_internet_gateway" "IGW" {
    vpc_id = aws_vpc.VPC.id

    tags = {
        Name = "Jenkins-IGW"
        Terraform = "true"
    }
}

# Create a Route Table
resource "aws_route_table" "RT" {
    vpc_id = aws_vpc.VPC.id

    route {
        cidr_block = var.route-cidr
        gateway_id = aws_internet_gateway.IGW.id
    }
}

# Create a Route Table Association
resource "aws_route_table_association" "RTA" {
    subnet_id = aws_subnet.Public.id
    route_table_id = aws_route_table.RT.id
}

#  Create a Security Group for the ports of Jenkins, SSH and http

resource "aws_security_group" "Sg" {
    name = "Jenkins-sg"
    vpc_id = aws_vpc.VPC.id

    dynamic "ingress" {
        for_each = var.ingress_ports
        content {
            from_port   = ingress.value
            to_port     = ingress.value
            protocol    = "tcp"
            cidr_blocks = ["0.0.0.0/0"]
        }
    }

    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }

    tags = {
        Name = "Jenkins-Sg"
        Terraform = "true"
    }
}

resource "aws_instance" "Jenkins-Server" {
    ami = var.ami
    instance_type = var.instance_type
    key_name = var.key_name
    subnet_id = aws_subnet.Public.id
    vpc_security_group_ids = [aws_security_group.Sg.id]
    associate_public_ip_address = var.associate_public_ip_address
    user_data = "${file("jenkins.sh")}"

    tags = {
        Name = "Jenkins-Server"
        Terraform = "true"
    }

    root_block_device {
        volume_size = "8"
    }
}


