resource "aws_ebs_volume" "volumex1" {
  availability_zone = var.ebs_azs
  size              = 7
  tags = {
    Group = "variablex"
  }
}
