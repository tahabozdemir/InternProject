 locals {
    route_table_ids = [for table in aws_route_table.route_table : table.id]
}