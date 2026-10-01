output "instance_id" {
  description = "EC2 instance ID"
  value       = aws_instance.this.id
}

output "public_ip" {
  description = "EC2 public IP"
  value       = aws_instance.this.public_ip
}

output "private_ip" {
  description = "EC2 private IP"
  value       = aws_instance.this.private_ip
}

output "security_group_id" {
  description = "Security Group ID"
  value       = aws_security_group.web.id
}

output "key_name" {
  description = "AWS key pair name"
  value       = aws_key_pair.this.key_name
}

output "ebs_volume_id" {
  description = "Additional EBS volume ID"
  value       = aws_ebs_volume.data.id
}