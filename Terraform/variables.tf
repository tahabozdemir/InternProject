variable "ec2_type" {
  type    = string
  default = "t2.micro"
}
variable "region" {
  type    = string
  default = "eu-west-1"
}

variable "configuration" {
  type = list(map(string))
}
