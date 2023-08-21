variable "vpc_cidr" {
  type    = string
  default = "172.16.0.0/16"
}

variable "subnet_public_cidr" {
  type    = string
  default = "172.16.1.0/24"
}

variable "subnet_availability_zones" {
  type = list(string)
  default = [
    "eu-west-1a",
    "eu-west-1b",
    "eu-west-1c"
  ]
}