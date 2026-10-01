########################################
# Get Default VPC
########################################

data "aws_vpc" "default" {
  default = true
}


########################################
# Get Subnets from Default VPC

data "aws_subnets" "default" {

  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.default.id]
  }
}


# Get Latest Amazon Linux 2023 AMI

data "aws_ami" "amazon_linux" {

  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["al2023-ami-2023.*-x86_64"]
  }

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}


########################################
# Create AWS Key Pair
########################################

resource "aws_key_pair" "this" {

  key_name = var.key_name

  public_key = file(var.public_key_path)

  tags = merge(
    var.tags,
    {
      Name = var.key_name
    }
  )
}


########################################
# Create Security Group
########################################

resource "aws_security_group" "web" {

  name        = "${var.instance_name}-sg"
  description = "Security group for Nginx EC2 server"

  vpc_id = data.aws_vpc.default.id

  tags = merge(
    var.tags,
    {
      Name = "${var.instance_name}-sg"
    }
  )
}


########################################
# Allow SSH Port 22
########################################

resource "aws_vpc_security_group_ingress_rule" "ssh" {

  security_group_id = aws_security_group.web.id

  description = "Allow SSH"

  cidr_ipv4 = var.ssh_cidr

  from_port = 22
  to_port   = 22

  ip_protocol = "tcp"
}


########################################
# Allow HTTP Port 80
########################################

resource "aws_vpc_security_group_ingress_rule" "http" {

  security_group_id = aws_security_group.web.id

  description = "Allow HTTP"

  cidr_ipv4 = "0.0.0.0/0"

  from_port = 80
  to_port   = 80

  ip_protocol = "tcp"
}


# Allow All Outbound Traffic

resource "aws_vpc_security_group_egress_rule" "all" {

  security_group_id = aws_security_group.web.id

  cidr_ipv4 = "0.0.0.0/0"

  ip_protocol = "-1"
}


# Create EC2 Instance

resource "aws_instance" "this" {

  ami = data.aws_ami.amazon_linux.id

  instance_type = var.instance_type

  subnet_id = sort(data.aws_subnets.default.ids)[0]

  associate_public_ip_address = true

  key_name = aws_key_pair.this.key_name

  vpc_security_group_ids = [
    aws_security_group.web.id
  ]

  user_data = file("${path.module}/user_data.sh")


  # Root EBS Volume

  root_block_device {

    volume_type = "gp3"

    volume_size = 8

    encrypted = true
  }


  tags = merge(
    var.tags,
    {
      Name = var.instance_name
    }
  )
}


# Create Additional EBS Volume

resource "aws_ebs_volume" "data" {

  availability_zone = aws_instance.this.availability_zone

  size = var.ebs_size

  type = "gp3"

  encrypted = true

  tags = merge(
    var.tags,
    {
      Name = "${var.instance_name}-data-volume"
    }
  )
}


# Attach EBS Volume to EC2

resource "aws_volume_attachment" "data" {

  device_name = "/dev/sdf"

  volume_id = aws_ebs_volume.data.id

  instance_id = aws_instance.this.id
}