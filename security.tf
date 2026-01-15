resource "aws_security_group" "hub_sg" {
  name   = "Hub-SG"
  vpc_id = aws_vpc.hub_vpc.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.my_ip]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "Hub-SG"
  }
}


resource "aws_security_group" "spoke_a_sg" {
  name   = "Spoke-A-SG"
  vpc_id = aws_vpc.spoke_a_vpc.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["10.0.0.0/16"]   # Hub VPC CIDR
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "Spoke-A-SG"
  }
}


resource "aws_security_group" "spoke_b_sg" {
  name   = "Spoke-B-SG"
  vpc_id = aws_vpc.spoke_b_vpc.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["10.0.0.0/16"]   # Hub VPC CIDR
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "Spoke-B-SG"
  }
}
