output "tg_puma_arn" {
    value = "${aws_lb_target_group.tg_puma.arn}"
}

output "tg_nodejs_arn" {
    value = "${aws_lb_target_group.tg_nodejs.arn}"
}