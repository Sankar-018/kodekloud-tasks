output "KKE_vpc_name" {
    value   = aws_vpc.xfusion-priv-vpc.tags["Name"]
}

output "KKE_subnet_name" {
  value = aws_subnet.xfusion-priv-subnet.tags["Name"]
}


output "KKE_ec2_private" {
    value   = aws_instance.xfusion-priv-ec2.tags["Name"]
}
