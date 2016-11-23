variable "name"           { }
variable "region"         { }
variable "profile"        { }

variable "az"             { }
variable "vpc_cidr"       { }
variable "subnet_cidr"    { }

variable "sg_name"        { }
variable "sg_description" { }
variable "sg_cidrs"       {
  type = "list"
}

variable "ami"            { }
variable "ebs_optimized"  { }
variable "monitoring"     { }
variable "key_name"       { }
variable "nodes"       { }
variable "instance_type"               { }
variable "associate_public_ip_address" { }
variable "source_dest_check"           { }
variable "volume_type"                 { }
variable "volume_size"                 { }
variable "delete_on_termination"       { }

provider "aws" {
  region  = "${var.region}"
  profile = "${var.profile}"
}

module "vpc" {
  source = "../modules/network/vpc"

  name = "${var.name}"
  cidr = "${var.vpc_cidr}"
}

module "subnet" {
  source = "../modules/network/subnet"

  name   = "${var.name}"
  vpc_id = "${module.vpc.vpc_id}"
  cidr   = "${var.subnet_cidr}"
  az     = "${var.az}"
}

module "route_table" {
  source = "../modules/network/route_table"

  name      = "${var.name}"
  vpc_id    = "${module.vpc.vpc_id}"
  subnet_id = "${module.subnet.subnet_id}"
}

module "security_group" {
  source = "../modules/network/security_group"

  name        = "${var.sg_name}"
  description = "${var.sg_description}"
  vpc_id      = "${module.vpc.vpc_id}"
  cidrs       = ["${var.sg_cidrs}"]
}

module "ec2" {
  source = "../modules/compute/ec2"

  name             = "${var.name}"
  ami              = "${var.ami}"
  ebs_optimized    = "${var.ebs_optimized}"
  monitoring       = "${var.monitoring}"
  key_name         = "${var.key_name}"
  subnet_id        = "${module.subnet.subnet_id}"
  sg_ids           = ["${module.security_group.sg_external_id}","${module.security_group.sg_operational_id}"]
  nodes                       = "${var.nodes}"
  instance_type               = "${var.instance_type}"
  associate_public_ip_address = "${var.associate_public_ip_address}"
  source_dest_check           = "${var.source_dest_check}"
  volume_type                 = "${var.volume_type}"
  volume_size                 = "${var.volume_size}"
  delete_on_termination       = "${var.delete_on_termination}"
}
