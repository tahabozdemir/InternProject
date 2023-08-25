variable "sg_db_id" {
  type = string
}

variable "vpc_subnet_private_ids" {
  type = list(string)
}

variable "db_identifier" {
  type    = string
  default = "sonarqubiyc-instance"
}

variable "db_instance_class" {
  type    = string
  default = "db.t3.micro"
}

variable "db_stroage_type" {
  type    = string
  default = "gp2"
}

variable "db_allocated_storage" {
  type    = number
  default = 20
}

variable "db_availability_zone" {
  type    = string
  default = "eu-west-1a"
}

