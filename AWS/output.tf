output "instance1_public_ip" {
  value = module.ec2-instance.instance_public_ip1
}

output "instance1_state" {
  value       = module.ec2-instance.instance_state1
  description = "The state of the server instance 1."
}

