variable name        { }
variable description { }
variable vpc_id      { }
variable cidrs       {
  type = "list"
}

resource "aws_security_group" "external" {
  name        = "${var.name}"
  description = "${var.description}"
  vpc_id      = "${var.vpc_id}"

  ingress {
      from_port       = 80
      to_port         = 80
      protocol        = "tcp"
      cidr_blocks     = ["${var.cidrs}"]
  }

  egress {
      from_port       = 0
      to_port         = 0
      protocol        = "-1"
      cidr_blocks     = ["0.0.0.0/0"]
  }

  tags {
      "Name" = "${var.name}"
  }
}

resource "aws_security_group" "operational" {
  name        = "operational"
  description = "For manual operation"
  vpc_id      = "${var.vpc_id}"

  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
  }

  tags {
    "Name" = "operational"
  }
}

output "sg_external_id" { value = "${aws_security_group.external.id}"}
output "sg_operational_id" { value = "${aws_security_group.operational.id}"}
