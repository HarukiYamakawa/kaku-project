output "vpc_id" {
    value = "${aws_vpc.default.id}"
}

output "public_subnet_ingress_1_id" {
    value = "${aws_subnet.public_subnet_ingress_1.id}"
}

output "public_subnet_ingress_2_id" {
    value = "${aws_subnet.public_subnet_ingress_2.id}"
}

output "private_subnet_nodejs_1_id" {
    value = "${aws_subnet.private_subnet_nodejs_1.id}"
}

output "private_subnet_nodejs_2_id" {
    value = "${aws_subnet.private_subnet_nodejs_2.id}"
}

output "private_subnet_puma_1_id" {
    value = "${aws_subnet.private_subnet_puma_1.id}"
}

output "private_subnet_puma_2_id" {
    value = "${aws_subnet.private_subnet_puma_2.id}"
}

output "private_subnet_mysql_1_id" {
    value = "${aws_subnet.private_subnet_mysql_1.id}"
}

output "private_subnet_mysql_2_id" {
    value = "${aws_subnet.private_subnet_mysql_2.id}"
}

output "private_subnet_redis_1_id" {
    value = "${aws_subnet.private_subnet_redis_1.id}"
}

output "private_subnet_redis_2_id" {
    value = "${aws_subnet.private_subnet_redis_2.id}"
}

output "private_subnet_vpc_endpoint_1_id" {
    value = "${aws_subnet.private_subnet_vpc_endpoint_1.id}"
}

output "private_subnet_vpc_endpoint_2_id" {
    value = "${aws_subnet.private_subnet_vpc_endpoint_2.id}"
}

output "route_nodejs_id" {
    value = "${aws_route_table.route_nodejs.id}"
}

output "route_puma_id" {
    value = "${aws_route_table.route_puma.id}"
}