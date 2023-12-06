
cidr_block = "10.0.0.0/16"

instance_tenancy = "default"

dns_hostnames = true

dns_support = true

public_cidr = "10.0.1.0/24"

public_ip = true

zones = "ap-south-1a"

route-cidr = "0.0.0.0/0"

ami = "ami-0287a05f0ef0e9d9a"

instance_type = "t2.micro"

key_name = "Minikube_Ravi"

associate_public_ip_address = true

ingress_ports = [80, 8080, 443, 22]