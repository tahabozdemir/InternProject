module "VPC" {
  source = "./modules/vpc"
}

module "SecurityGroup" {
  source        = "./modules/security_group"
  ubuntu_vpc_id = module.VPC.vpc_id
}

module "RegistryBucket" {
  source = "./modules/s3"
}

resource "aws_instance" "ubuntu_server" {
  for_each                    = { for server in var.configuration : server.server_name => server }
  ami                         = data.aws_ami.Ubuntu.id
  instance_type               = var.ec2_type
  key_name                    = "TahaPair"
  iam_instance_profile        = module.RegistryBucket.registry_iam_profile_id
  associate_public_ip_address = true
  user_data                   = file("${each.value.user_data}")
  subnet_id                   = module.VPC.vpc_subnet_public_id
  vpc_security_group_ids      = [lookup(module.SecurityGroup, "${each.value.vpc_security_group_ids}")]

  tags = {
    Name = "${each.value.server_name}"
  }
}