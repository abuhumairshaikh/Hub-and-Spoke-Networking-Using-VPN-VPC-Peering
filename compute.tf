data "aws_ami" "amazon_linux" {
most_recent = true
owners = ["amazon"]

filter {
name = "name"
values = ["amzn2-ami-hvm-*-x86_64-gp2"]
}
}

resource "aws_instance" "hub_vpn_server" {
ami = data.aws_ami.amazon_linux.id
instance_type = "t3.micro"
subnet_id = aws_subnet.hub_public_subnet.id
vpc_security_group_ids = [aws_security_group.hub_sg.id]
key_name = var.key_name
associate_public_ip_address = true
tags = { Name = "Hub-VPN-Server" }
}


resource "aws_instance" "spoke_a_app" {
  ami                    = data.aws_ami.amazon_linux.id
  instance_type          = "t3.micro"
  subnet_id              = aws_subnet.spoke_a_subnet.id
  vpc_security_group_ids = [aws_security_group.spoke_a_sg.id]
  key_name               = var.key_name

  tags = {
    Name = "Spoke-A-App"
  }
}



resource "aws_instance" "spoke_b_app" {
  ami                    = data.aws_ami.amazon_linux.id
  instance_type          = "t3.micro"
  subnet_id              = aws_subnet.spoke_b_subnet.id
  vpc_security_group_ids = [aws_security_group.spoke_b_sg.id]
  key_name               = var.key_name

  tags = {
    Name = "Spoke-B-App"
  }
}
