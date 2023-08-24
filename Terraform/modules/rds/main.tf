resource "aws_db_subnet_group" "db_subnet_group" {
  name       = "db_subnet_group"
  subnet_ids = [var.vpc_subnet_private_id]
}

resource "aws_db_instance" "db_instance" {
  identifier             = var.db_identifier
  engine                 = "postgresql"
  instance_class         = var.db_instance_class
  allocated_storage      = var.db_allocated_storage
  storage_type           = var.db_stroage_type
  publicly_accessible    = false
  availability_zone      = var.db_availability_zone
  db_name                = var.db_name
  username               = var.db_username
  password               = var.db_password
  db_subnet_group_name   = aws_db_subnet_group.ghost_db_subnet_group.name
  vpc_security_group_ids = [var.sg_db_id]
  skip_final_snapshot    = true

  tags = {
    Name = "RDS PostgreSQL"
  }
}
