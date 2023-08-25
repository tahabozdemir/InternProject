resource "aws_security_group" "sg_control_node" {
  name        = var.sg_control_node_name
  description = var.sg_control_node_description
  vpc_id      = var.ubuntu_vpc_id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.allowed_ssh_ip]
    description = "SSH access"
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = [var.allowed_http_ip]
    description = "HTTP access"
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = [var.allowed_https_ip]
    description = "HTTPS access"
  }

   ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = [var.allowed_jenkins_ip]
    description = "Jenkins access"
  }

    ingress {
    from_port   = 3000
    to_port     = 3000
    protocol    = "tcp"
    cidr_blocks = [var.allowed_grafana_ip]
    description = "Grafana access"
  }
    ingress {
    from_port   = 9090
    to_port     = 9090
    protocol    = "tcp"
    cidr_blocks = [var.allowed_prometheus_ip]
    description = "Prometheus access"
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "sg_managed_node" {
  name        = var.sg_managed_node_name
  description = var.sg_managed_node_description
  vpc_id      = var.ubuntu_vpc_id
  depends_on = [
    aws_security_group.sg_control_node
  ]

  ingress {
    from_port       = "22"
    to_port         = "22"
    protocol        = "tcp"
    security_groups = [aws_security_group.sg_control_node.id]
    description     = "Allow SSH traffic from only the sg_control_node"
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = [var.allowed_http_ip]
    description = "HTTP access"
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = [var.allowed_https_ip]
    description = "HTTPS access"
  }

    ingress {
    from_port   = 9000
    to_port     = 9000
    protocol    = "tcp"
    cidr_blocks = [var.allowed_sonarqube_ip]
    description = "sonarQube access"
  }

    ingress {
    from_port   = 5000
    to_port     = 5000
    protocol    = "tcp"
    cidr_blocks = [var.allowed_registry_ip]
    description = "Registry access"
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "sg_db" {
  name        = var.sg_db_name
  description = var.sg_db_description
  vpc_id      = var.ubuntu_vpc_id

  ingress {
    from_port       = "5432"
    to_port         = "5432"
    protocol        = "tcp"
    security_groups = [aws_security_group.sg_managed_node.id]
    description     = "Allow PostgreSQL traffic from only the sg_managed_node"
  }
}