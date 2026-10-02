############################################
# Get Default VPC
############################################

data "aws_vpc" "my_vpc" {
  default = true
}


############################################
# Get Available Availability Zones
############################################

data "aws_availability_zones" "available" {
  state = "available"
}


############################################
# Get Default Subnet
############################################

data "aws_subnet" "default_subnet" {
  vpc_id            = data.aws_vpc.my_vpc.id
  availability_zone = data.aws_availability_zones.available.names[0]
  default_for_az    = true
}


############################################
# Create EC2 Key Pair
############################################

resource "aws_key_pair" "my_key" {
  key_name   = var.key_name
  public_key = var.public_key

  tags = merge(
    var.tags,
    {
      Name = var.key_name
    }
  )
}


############################################
# Create Security Group
############################################

resource "aws_security_group" "web_sg" {
  name        = "${var.instance_name}-sg"
  description = "Allow SSH and HTTP"
  vpc_id      = data.aws_vpc.my_vpc.id

  ingress {
    description = "Allow SSH"

    from_port = 22
    to_port   = 22
    protocol  = "tcp"

    cidr_blocks = var.ssh_cidrs
  }

  ingress {
    description = "Allow HTTP"

    from_port = 80
    to_port   = 80
    protocol  = "tcp"

    cidr_blocks = var.http_cidrs
  }

  egress {
    description = "Allow all outbound traffic"

    from_port = 0
    to_port   = 0
    protocol  = "-1"

    cidr_blocks = var.egress_cidrs
  }

  tags = merge(
    var.tags,
    {
      Name = "${var.instance_name}-sg"
    }
  )
}


############################################
# Create EC2 Instance
############################################

resource "aws_instance" "nginx_server" {
  ami           = var.ami_id
  instance_type = var.instance_type

  subnet_id = data.aws_subnet.default_subnet.id

  associate_public_ip_address = true

  key_name = aws_key_pair.my_key.key_name

  vpc_security_group_ids = [
    aws_security_group.web_sg.id
  ]

  user_data = file("${path.module}/user_data.sh")


  ##########################################
  # Root EBS Volume
  ##########################################

  root_block_device {
    volume_type = "gp3"
    volume_size = var.root_volume_size
    encrypted   = true
  }


  tags = merge(
    var.tags,
    {
      Name = var.instance_name
    }
  )
}


############################################
# Create Additional EBS Volume
############################################

resource "aws_ebs_volume" "data" {
  availability_zone = aws_instance.nginx_server.availability_zone

  size      = var.ebs_size
  type      = "gp3"
  encrypted = true

  tags = merge(
    var.tags,
    {
      Name = "${var.instance_name}-data-volume"
    }
  )
}


############################################
# Attach Additional EBS Volume
############################################

resource "aws_volume_attachment" "data" {
  device_name = "/dev/sdf"

  volume_id = aws_ebs_volume.data.id

  instance_id = aws_instance.nginx_server.id
}