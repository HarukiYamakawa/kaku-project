output "puma_log_group" {
    value = "${aws_cloudwatch_log_group.puma-log.name}"
}

output "nodejs_log_group" {
    value = "${aws_cloudwatch_log_group.nodejs-log.name}"
}