name    = "micro"
region  = "ap-northeast-1"
profile = "gyazo-terraform"

az          = "ap-northeast-1"
vpc_cidr    = "10.0.0.0/16"
subnet_cidr = "10.0.1.0/24"

sg_name        = "external"
sg_description = "For front instance. Permit http from anywhere."
sg_cidrs       = ["0.0.0.0/0"]

ami                         = "ami-7243e611"
ebs_optimized               = "false"
monitoring                  = "false"
key_name                    = "aws-private" # キーペア
nodes                       = "1"
instance_type               = "t2.micro"
associate_public_ip_address = "true"
source_dest_check           = "true"
volume_type                 = "standard"
volume_size                 = "100"
delete_on_termination       = "false"
