///////////////////////////////////////////////////////////////////////////////
// Top-level AWS values
///////////////////////////////////////////////////////////////////////////////
variable "aws_region" {
  type        = string
  nullable    = false
  default     = "us-west-2"
  description = "AWS region in which resources are create."
}

///////////////////////////////////////////////////////////////////////////////
// Networking values
///////////////////////////////////////////////////////////////////////////////
variable "vpc_name" {
  type        = string
  nullable    = false
  default     = "pocketbase"
  description = "Name of the VPC."
}

variable "internet_gateway_name" {
  type        = string
  nullable    = false
  default     = "pocketbase"
  description = "Name of the internet gateway created in the VPC."
}

variable "subnet_name" {
  type        = string
  nullable    = false
  default     = "pocketbase"
  description = "Name of the VPC subnet."
}

variable "route_table_name" {
  type        = string
  nullable    = false
  default     = "pocketbase public"
  description = "Name of the subnet route table."
}

///////////////////////////////////////////////////////////////////////////////
// Security group values
///////////////////////////////////////////////////////////////////////////////
variable "security_group_name" {
  type        = string
  nullable    = false
  default     = "pocketbase"
  description = "Name of the pocketbase EC2 security group."
}

variable "ssh_cidrs" {
  type        = set(string)
  nullable    = false
  default     = ["24.16.132.54/32"]
  description = "List of CIDR ranges from which to allow SSH connections."
}

///////////////////////////////////////////////////////////////////////////////
// EC2 instance values
///////////////////////////////////////////////////////////////////////////////
variable "ec2_instance_name" {
  type        = string
  nullable    = false
  default     = "pocketbase"
  description = "Name of the EC2 instance."
}

variable "ec2_instance_type" {
  type        = string
  nullable    = false
  default     = "t4g.small"
  description = "Type of EC2 instance. Default is recommended, but t4g.micro is 50% less expensive and may also work."
}

variable "ebs_volume_size" {
  type        = number
  nullable    = false
  default     = 8
  description = "Amount of storage (GB) attached to EC2 instance."
}

variable "authorized_ssh_key" {
  type        = string
  nullable    = false
  default     = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJ/uFrQr4KZ1jNgflo7ISQyByqQ+ACkhFwkfkz1zhRk4 chaochaowong+github@gmail.com"
  description = "Public SSH key authorized to connect to the EC2 instance."
}
