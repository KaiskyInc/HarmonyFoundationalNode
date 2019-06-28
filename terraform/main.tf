# Find latest Ubuntu 18.04 AMI
data "aws_ami" "ubuntu" {
  owners      = ["099720109477"]
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-bionic-18.04-amd64-server-*"]
  }

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }
}

# Key Pair
# Uncomment the resource below if you do not already have
# an existing key pair. Create one locally and copy and paste
# into "public_key" field.
# resource "aws_key_pair" "foundational_node" {
#   key_name   = "foundational_node"
#   public_key = "$YOUR_PUBLIC_KEY"
# }

resource "aws_instance" "foundational-node" {
  ami                    = "${data.aws_ami.ubuntu.id}"
  instance_type          = "${var.node_instance_type}"
  key_name               = "${var.node_key_name}"
  vpc_security_group_ids = ["${aws_security_group.foundational-sg.id}"]
  subnet_id              = "${aws_subnet.foundational-subnet.id}"

  root_block_device = {
    volume_type = "gp2"
    volume_size = "${var.node_volume_size}"
  }

  tags = {
    Name    = "HarmonyFoundationalNode-1"
    Project = "Harmony"
  }

  volume_tags = {
    Name    = "HarmonyFoundationalVolume"
    Project = "Harmony"
  }
}
