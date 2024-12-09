provider "aws" {
  region     = "us-east-1"
}
resource "aws_instance" "public_subnet-1" {
ami="ami-0166fe664262f664c"
instance_type="t2.micro"
count=1
key_name="new-key"
vpc_security_group_ids=["${aws_security_group.demosg.id}"]
user_data="${file("userdata.sh")}"
tags={
Name="My Terraform "
}
}

resource "aws_security_group" "demosg" {

ingress{
from_port=80
to_port=80
protocol="tcp"
cidr_blocks=["0.0.0.0/0"]
}

ingress{
from_port=3306
to_port=3306
protocol="tcp"
cidr_blocks=["0.0.0.0/0"]
}

ingress{
from_port=22
to_port=22
protocol="tcp"
cidr_blocks=["0.0.0.0/0"]
}

ingress{
from_port=8080
to_port=8080
protocol="tcp"
cidr_blocks=["0.0.0.0/0"]
}

egress{
from_port=0
to_port=0
protocol="-1"
cidr_blocks=["0.0.0.0/0"]
}
tags={
Name="WEB SG"
}
}