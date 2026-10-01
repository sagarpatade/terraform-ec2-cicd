output "instance_id" {
  value = module.web_server.instance_id
}

output "public_ip" {
  value = module.web_server.public_ip
}

output "private_ip" {
  value = module.web_server.private_ip
}

output "security_group_id" {
  value = module.web_server.security_group_id
}

output "ebs_volume_id" {
  value = module.web_server.ebs_volume_id
}

output "nginx_url" {
  value = "http://${module.web_server.public_ip}"
}