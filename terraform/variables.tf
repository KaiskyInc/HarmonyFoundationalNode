// VPC configurations
variable "vpc_cidr_block" {
  description = "CIDR block of the VPC"
  default     = "10.0.0.0/16"
}

variable "subnet_cidr_block" {
  description = "CIDR block of the EC2 subnet"
  default     = "10.0.0.0/24"
}

variable "subnet_az" {
  description = "Availability zone of the EC2 subnet"
  default     = "us-west-2a"
}

// EC2 instance configurations
variable "node_instance_type" {
  description = "Instance type of the node instance"
  default     = "m5.large"
}

variable "node_key_name" {
  description = "Key Pair name of the node instance"
  default     = "foundational_node"
}

variable "node_volume_size" {
  description = "Root Volume size of the node instance"
  default     = 30
}
