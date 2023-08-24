variable "sg_control_node_name" {
  type        = string
  description = "Name of the control node security group"
  default     = "sg_control"
}

variable "sg_managed_node_name" {
  type        = string
  description = "Name of the managed node security group"
  default     = "sg_managed"
}

variable "sg_db_name" {
  type        = string
  description = "Name of the managed node security group"
  default     = "sg_managed"
}

variable "sg_db_description" {
  type        = string
  description = "Description of Database security group"
  default     = "Allow PostgreSQL access to servers."
}

variable "sg_control_node_description" {
  type        = string
  description = "Description of the control node security group"
  default     = "Allow SSH, HTTP and HTTPS access to servers."
}

variable "sg_managed_node_description" {
  type        = string
  description = "Description of the managed node security group"
  default     = "Allow SSH access to servers."
}

variable "allowed_ssh_ip" {
  description = "Allowed IP for SSH access"
  default     = "0.0.0.0/0"
}

variable "allowed_http_ip" {
  description = "Allowed IP for HTTP access"
  default     = "0.0.0.0/0"
}

variable "allowed_https_ip" {
  description = "Allowed IP for HTTPS access"
  default     = "0.0.0.0/0"
}

variable "ubuntu_vpc_id" {
  type = string
}