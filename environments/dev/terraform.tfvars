ami_id = "ami-03054015e26069645"

instance_name = "dev-nginx-server"

instance_type = "t3.micro"

key_name = "dev-terraform-key"

root_volume_size = 8

ebs_size = 10

ssh_cidrs = [
  "0.0.0.0/0"
]

http_cidrs = [
  "0.0.0.0/0"
]

egress_cidrs = [
  "0.0.0.0/0"
]