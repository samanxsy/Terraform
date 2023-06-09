output "instance1_id" {
  value = aws_instance.instancex1.id
}

output "instance_public_ip1" {
  value = aws_instance.instancex1.public_ip
}

output "instance_state1" {
  value = aws_instance.instancex1.instance_state
}

output "ssh_key_name" {
  value = aws_key_pair.ssh_pair.key_name
}
