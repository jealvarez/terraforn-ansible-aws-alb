resource "aws_key_pair" "testing" {
  key_name   = "testing"
  public_key = file("${var.ssh_private_key_path}.pub")

}

resource "aws_security_group" "ec2_instance" {
  vpc_id = aws_vpc.main.id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = -1
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "web_server_a" {
  ami                         = "ami-066df92ac6f03efca"
  associate_public_ip_address = true
  instance_type               = "t2.micro"
  subnet_id                   = aws_subnet.subnet_a.id
  vpc_security_group_ids      = [aws_security_group.ec2_instance.id]
  key_name                    = aws_key_pair.testing.id

  provisioner "local-exec" {
    command = "sleep 120; ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -u ec2-user --private-key ${var.ssh_private_key_path} -i '${self.public_ip},' ./configuration/playbook.yml"
  }
}

resource "aws_instance" "web_server_b" {
  ami                         = "ami-066df92ac6f03efca"
  instance_type               = "t2.micro"
  associate_public_ip_address = true
  subnet_id                   = aws_subnet.subnet_b.id
  vpc_security_group_ids      = [aws_security_group.ec2_instance.id]
  key_name                    = aws_key_pair.testing.id

  provisioner "local-exec" {
    command = "sleep 120; ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -u ec2-user --private-key ${var.ssh_private_key_path} -i '${self.public_ip},' ./configuration/playbook.yml"
  }
}
