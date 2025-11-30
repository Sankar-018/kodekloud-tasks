resource "aws_instance" "devops-ec2" {
  ami                    = "ami-0c101f26f147fa7fd"
  instance_type          = "t2.micro"
  vpc_security_group_ids = [data.aws_security_group.default.id]
  key_name               = aws_key_pair.devops-kp.key_name

  tags = {
    Name = "devops-ec2"
  }
}

resource "aws_key_pair" "devops-kp" {
  key_name   = "devops-kp"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDD6wBUnVXQVbaEQrBGQAiuDr3e2tNddRrGhypO3ghylfSn1rTJZNiJ2/uA+5USQh4vbOxBAmDka07vpJbl69IjHPoBO0tOGJvTbmP3LRukiorTisYz80FBKV50SwyoH4DAEdFYKdCWpWl8HB0TTwsyYPzVJCkAGtX6qfB+69LAnaNeFvX+CT9VM0ZhMgPCne69e0g5Q/YKbgAgZ7p+CMNjME0PVYGpHMhwvok5/IGHA335tc0rywYpYLFOS563vZDzdCoaoaA0195nMJaCeMw25aEXO4mL61XbOS8UKE1zUThrpF1ugomzJEIXPEDPB7I7P26wz6uU0piyVBjE0tIWtj+TrPElqrGkmTTCKLm6FdgRgI4RvsiK2uz8hXayv2zNh320J997puzpiUro9rDuu+un1q5Sy+u1oiAwBEFQFVx0qq7rUmIEiFlK7BNfNH9YaBdOkvC5yQKP+0aHnJE2aGceRQGXK2HR/AP6efbrlycg5lFGz6NFU+9IbJR18qM= bob@iac-server"
}

data "aws_security_group" "default" {
    name = "default"
}