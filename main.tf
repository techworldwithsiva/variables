resource "aws_vpc" "main" {
    cidr_block       = var.cidr_block
    instance_tenancy = var.instance_tenancy
    enable_dns_support = var.dns_support
    enable_dns_hostnames = var.dns_hostnames
    tags = var.tags
}

resource "aws_subnet" "public" {
  for_each = var.public_subnets
  vpc_id = aws_vpc.main.id
  cidr_block = each.value.cidr_block
  availability_zone = each.value.az

  tags = {
    Name = each.value.Name
  }
}


# security group for postgress RDS, 5432
resource "aws_security_group" "allow_postgress" {
  name        = "allow_postgress"
  description = "Allow postgress inbound traffic"
  vpc_id      = aws_vpc.main.id

  ingress {
    description      = "TLS from VPC"
    from_port        = var.postgress_port
    to_port          = var.postgress_port
    protocol         = "tcp"
    cidr_blocks      = var.cidr_list
   
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = merge(
    var.tags,
    {
        Name = "timing-RDS-SG"
    }
  )
}

# this will be created inside default VPC
# AMI ID are different for different regions
# this is a loop that can run 3 times
# resource "aws_instance" "web-server" {
#     count = 3
#     ami = "ami-012b9156f755804f5"
#     instance_type = "m3.large"
#     tags = {
#         Name = var.instance_names[count.index]
#     }
# }

resource "aws_key_pair" "terraform" {
  key_name   = "terraform"
  public_key = file("C:\\Users\\user\\terraform.pub")
}

resource "aws_instance" "condition" {
    key_name = aws_key_pair.terraform.key_name
    ami = "ami-012b9156f755804f5"
    instance_type = var.env == "PROD" ? "t3.large" : "t2.micro"
}
