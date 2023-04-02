output "ec2_public_dns" {
  value = aws_instance.jenkins_instance.public_dns
}

output "ec2_public_ip" {
  value = aws_eip.eip.public_ip
}