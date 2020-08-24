output "ip" {
  value = aws_eip.ip.public_ip
}

from 
#resource "aws_eip" "ip" {
#  vpc = true
#  instance = aws_instance.example.id
#}

#terraform output ip