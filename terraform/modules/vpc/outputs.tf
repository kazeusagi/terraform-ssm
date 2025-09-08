output "subnet_id" {
  value = aws_subnet.public_1a.id
}

output "security_group_id" {
  value = aws_default_security_group.main.id
}
