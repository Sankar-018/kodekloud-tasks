output "KKE_instance_name" {
    value   = aws_instance.xfusion_ec2.tags["Name"]
}

output "KKE_alarm_name" {
    value   = aws_cloudwatch_metric_alarm.xfusion_alarm.alarm_name
}

