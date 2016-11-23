variable "name"          { }
variable "vpc_id"        { }
variable "cidr"          { }
variable "az"            { }

resource "aws_subnet" "public" {
  vpc_id            = "${var.vpc_id}"
  cidr_block        = "${var.cidr}"
  availability_zone = "${var.az}"

  tags {
    Name = "${var.name}"
  }

  map_public_ip_on_launch = false
}

output "subnet_id"        { value = "${aws_subnet.public.id}" }
