output "static_contents_bucket_name" {
  value = "${aws_s3_bucket.public_bucket_static_contents.bucket_regional_domain_name}"
}

output "static_contents_bucket_arn" {
  value = "${aws_s3_bucket.public_bucket_static_contents.arn}"
}