module "VPC" {
  source = "./modules/vpc"
  configuration_rt = [
    {
        "route_table_name" : "Public Route Table"
    },
    {
        "route_table_name" : "Private Route Table"
    }
]
}

module "SecurityGroup" {
  source        = "./modules/security_group"
  ubuntu_vpc_id = module.VPC.vpc_id
}

module "RegistryBucket" {
  source = "./modules/s3"
}

module "RDS" {
  source                 = "./modules/rds"
  vpc_subnet_private_id  = module.VPC.vpc_subnet_private_id
  sg_db_id               = module.SecurityGroup.sg_db_id
}

resource "aws_eip" "elastic_ip" {
  for_each = { for server in var.configuration : server.server_name => server }
  instance = aws_instance.ubuntu_server["${each.value.server_name}"].id
  tags = {
    Name = "${each.value.server_name} IP"
  }
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