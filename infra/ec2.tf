///////////////////////////////////////////////////////////////////////////////
// Security group
///////////////////////////////////////////////////////////////////////////////
resource "aws_security_group" "pocketbase" {
  name        = var.security_group_name
  description = "Allow ports necessary for pocketbase"
  vpc_id      = aws_vpc.pocketbase.id

  tags = {
    Name = var.security_group_name
  }
}

resource "aws_vpc_security_group_ingress_rule" "pocketbase_http_ipv4" {
  security_group_id = aws_security_group.pocketbase.id

  cidr_ipv4   = "0.0.0.0/0"
  from_port   = 80
  to_port     = 80
  ip_protocol = "tcp"
}

resource "aws_vpc_security_group_ingress_rule" "pocketbase_http_ipv6" {
  security_group_id = aws_security_group.pocketbase.id

  cidr_ipv6   = "::/0"
  from_port   = 80
  to_port     = 80
  ip_protocol = "tcp"
}

resource "aws_vpc_security_group_ingress_rule" "pocketbase_https_ipv4" {
  security_group_id = aws_security_group.pocketbase.id

  cidr_ipv4   = "0.0.0.0/0"
  from_port   = 443
  to_port     = 443
  ip_protocol = "tcp"
}

resource "aws_vpc_security_group_ingress_rule" "pocketbase_https_ipv6" {
  security_group_id = aws_security_group.pocketbase.id

  cidr_ipv6   = "::/0"
  from_port   = 443
  to_port     = 443
  ip_protocol = "tcp"
}

resource "aws_vpc_security_group_ingress_rule" "pocketbase_ssh" {
  for_each          = var.ssh_cidrs
  security_group_id = aws_security_group.pocketbase.id

  cidr_ipv4   = each.value
  from_port   = 22
  to_port     = 22
  ip_protocol = "tcp"
}

resource "aws_vpc_security_group_egress_rule" "pocketbase_out" {
  security_group_id = aws_security_group.pocketbase.id

  cidr_ipv4   = "0.0.0.0/0"
  ip_protocol = -1
}

///////////////////////////////////////////////////////////////////////////////
// Instance
///////////////////////////////////////////////////////////////////////////////
resource "aws_instance" "pocketbase" {
  ami           = "ami-012bf399e76fe4368" // Ubuntu 22.04
  instance_type = var.ec2_instance_type
  subnet_id     = aws_subnet.pocketbase.id

  vpc_security_group_ids = [aws_security_group.pocketbase.id]

  root_block_device {
    volume_size = var.ebs_volume_size
  }

  metadata_options {
    http_tokens = "required"
  }

  tags = {
    Name = var.ec2_instance_name
  }

  user_data = base64encode(templatefile("ec2_user_data.yaml", {
    ssh_public_key = var.authorized_ssh_key
  }))
}

output "pocketbase_instance_ip_addr" {
  value = aws_instance.pocketbase.public_ip
}
