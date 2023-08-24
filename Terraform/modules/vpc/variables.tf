variable "vpc_cidr" {
  type    = string
  default = "172.16.0.0/16"
}

variable "configuration_rt" {
  type = list(map(string))
}

variable "required_subnets" {
  description = "list of subnets required"
  default     = ["public-1a", "private-1a", "public-1b", "private-1b"]
}

variable "subnet_config" {
  type = map(object({
    cidr              = string
    availability_zone = string
  }))
  default = {
    "public-1a" : {
      cidr              = "172.16.1.0/24"
      availability_zone = "eu-west-1a"
    },
    "private-1a" : {
      cidr              = "172.16.100.0/24"
      availability_zone = "eu-west-1a"
    },
    "private-1b" : {
      cidr              = "172.16.101.0/24"
      availability_zone = "eu-west-1b"
    }
  }
}