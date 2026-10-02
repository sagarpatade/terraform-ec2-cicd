ami_id = "ami-03054015e26069645"

instance_name = "prod-nginx-server"

instance_type = "t3.small"

key_name = "prod-terraform-key"

root_volume_size = 10

ebs_size = 20

ssh_cidrs = [
  "0.0.0.0/0"
]

http_cidrs = [
  "0.0.0.0/0"
]

egress_cidrs = [
  "0.0.0.0/0"
]