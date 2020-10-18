
variable "vpc_id" {
  type = string
  default = "vpc-e981cd91"
}
resource "aws_security_group" "terraform_ec2_sg" {
  name = "terraform-ssh-sg"
  description = "terraform sg"
  vpc_id = var.vpc_id
  ingress {
    from_port = 22
    protocol = "tcp"
    to_port = 22
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port = 22
    protocol = "tcp"
    to_port = 22
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "terraform_ec2" {
  ami = "ami-01fee56b22f308154"
  instance_type = "t2.micro"
  key_name = "terraform"
  vpc_security_group_ids = [aws_security_group.terraform_ec2_sg.id]
}
