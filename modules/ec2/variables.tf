# AMI
variable "ami_id" {
  description = "AMI ID used for the EC2 instance"
  type        = string
}

# EC2 Instance

variable "instance_name" {
  description = "Name of the EC2 instance"
  type        = string
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
}

# Key Pair

variable "key_name" {
  description = "Name of the EC2 key pair"
  type        = string
}

variable "public_key" {
  description = "Public SSH key content"
  type        = string
}

# Security Group

variable "ssh_cidrs" {
  description = "CIDR blocks allowed for SSH"
  type        = list(string)
}

variable "http_cidrs" {
  description = "CIDR blocks allowed for HTTP"
  type        = list(string)
}

variable "egress_cidrs" {
  description = "CIDR blocks allowed for outbound traffic"
  type        = list(string)
}

# EBS Volumes

variable "root_volume_size" {
  description = "Root EBS volume size in GB"
  type        = number
}

variable "ebs_size" {
  description = "Additional EBS volume size in GB"
  type        = number
}

# Tags

variable "tags" {
  description = "Common tags applied to AWS resources"
  type        = map(string)
  default     = {}
}