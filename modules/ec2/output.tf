output "instance_id" {
  description = "EC2 instance ID"
  value       = aws_instance.nginx_server.id
}

output "public_ip" {
  description = "EC2 public IP"
  value       = aws_instance.nginx_server.public_ip
}

output "private_ip" {
  description = "EC2 private IP"
  value       = aws_instance.nginx_server.private_ip
}

output "security_group_id" {
  description = "Security Group ID"
  value       = aws_security_group.web_sg.id
}

output "key_name" {
  description = "AWS key pair name"
  value       = aws_key_pair.my_key.key_name
}

output "ebs_volume_id" {
  description = "Additional EBS volume ID"
  value       = aws_ebs_volume.data.id
}