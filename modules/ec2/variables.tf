variable "instance_name" {
  description = "nginix-server"
  type        = string
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t3.micro"
}

variable "key_name" {
  description = "AWS EC2 key pair name"
  type        = string
}

variable "public_key_path" {
  description = "terraform-module-lab/terraform-lab-key.pub"
  type        = string
}

variable "ebs_size" {
  description = "Additional EBS volume size in GB"
  type        = number
  default     = 10
}

variable "ssh_cidr" {
  description = "CIDR allowed for SSH"
  type        = string
  default     = "0.0.0.0/0"
}

variable "tags" {
  description = "Common tags"
  type        = map(string)
  default     = {}
}