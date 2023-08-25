locals {
  public_subnet = { for name, subnet in module.VPC.subnets : name => subnet if length(regexall("public-", name)) > 0 }

  private_subnet = { for name, subnet in module.VPC.subnets : name => subnet if length(regexall("private-", name)) > 0 }

  private_subnet_ids = [
    for subnet in local.private_subnet :
    subnet.id
  ]
}