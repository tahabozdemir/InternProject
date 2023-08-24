output "sg_control_node_id" {
  value = aws_security_group.sg_control_node.id
}

output "sg_managed_node_id" {
  value = aws_security_group.sg_managed_node.id
}

output "sg_db_id" {
  value = aws_security_group.sg_db.id
}