module "web_server" {
  source = "./modules/ec2"

  instance_name = "terraform-nginx-server"
  instance_type = "t3.micro"

  key_name = "terraform-lab-key"

  public_key_path = "${path.root}/terraform-lab-key.pub"

  ebs_size = 10

  ssh_cidr = "0.0.0.0/0"

  tags = {
    Environment = "dev"
    Project     = "terraform-module-lab"
    ManagedBy   = "terraform"
  }
}