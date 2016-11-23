variable "name"              { }
variable "vpc_id"            { }
variable "subnet_id"         { }

resource "aws_internet_gateway" "public" {
  vpc_id = "${var.vpc_id}"

  tags {
    Name = "${var.name}"
  }
}

resource "aws_route_table" "public" {
  vpc_id = "${var.vpc_id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.public.id}"
  }

  tags {
    Name = "${var.name}"
  }
}

resource "aws_route_table_association" "public" {
  subnet_id      = "${var.subnet_id}"
  route_table_id = "${aws_route_table.public.id}"
}
