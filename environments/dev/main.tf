module "web_server" {
  source = "../../modules/ec2"

  ami_id        = var.ami_id
  instance_name = var.instance_name
  instance_type = var.instance_type

  key_name   = var.key_name
  public_key = var.public_key

  ssh_cidrs    = var.ssh_cidrs
  http_cidrs   = var.http_cidrs
  egress_cidrs = var.egress_cidrs

  root_volume_size = var.root_volume_size
  ebs_size         = var.ebs_size

  tags = {
    Environment = "dev"
    Project     = "terraform-module-lab"
    ManagedBy   = "terraform"
  }
}