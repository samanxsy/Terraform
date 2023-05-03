resource "aws_key_pair" "ssh_pair" {
  key_name = "ec2key"
  public_key = file("./modules/ec2-instance/ec2key.pub")
}

resource "aws_instance" "instancex1" {
  ami                         = var.machine_image
  instance_type               = var.instance_type
  availability_zone           = var.aws_instance_azs
  subnet_id                   = var.aws_subnet_id
  associate_public_ip_address = true
  key_name                    = aws_key_pair.ssh_pair.key_name
  tags = {
    Name  = "${var.aws_instance_name}-1"
    Group = "variablex"
  }
}

resource "aws_instance" "instancex2" {
  ami                         = var.machine_image
  instance_type               = var.instance_type
  availability_zone           = var.aws_instance_azs
  subnet_id                   = var.aws_subnet_id
  associate_public_ip_address = true
  key_name                    = aws_key_pair.ssh_pair.key_name
  tags = {
    Name  = "${var.aws_instance_name}-2"
    Group = "variablex"
  }
}
