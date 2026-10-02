variable "ami_id" {
  description = "AMI ID for PROD EC2"
  type        = string
}

variable "instance_name" {
  description = "PROD EC2 instance name"
  type        = string
}

variable "instance_type" {
  description = "PROD EC2 instance type"
  type        = string
}

variable "key_name" {
  description = "PROD EC2 key pair name"
  type        = string
}

variable "ssh_cidrs" {
  description = "CIDRs allowed for SSH"
  type        = list(string)
}

variable "http_cidrs" {
  description = "CIDRs allowed for HTTP"
  type        = list(string)
}

variable "egress_cidrs" {
  description = "CIDRs allowed for outbound traffic"
  type        = list(string)
}

variable "root_volume_size" {
  description = "Root EBS volume size"
  type        = number
}

variable "ebs_size" {
  description = "Additional EBS volume size"
  type        = number
}

variable "public_key" {
  description = "SSH public key for EC2"
  type        = string
}