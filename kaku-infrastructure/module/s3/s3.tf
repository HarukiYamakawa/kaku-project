resource "aws_s3_bucket" "public_bucket_static_contents" {
  bucket = "${var.name_prefix}-public-bucket-static-contents"

  tags = {
    Name = "${var.tag_name}-public-bucket-static-contents"
    group = "${var.tag_group}"
  }
}

resource "aws_s3_bucket_public_access_block" "public_bucket_static_contents_public_access_block" {
  bucket = aws_s3_bucket.public_bucket_static_contents.id

  block_public_acls       = true
  ignore_public_acls      = true
  #ポリシーによるパブリックアクセスをブロックしない
  block_public_policy     = false
  #ポリシーによるパブリックアクセスをAWSサービス内に限定しない
  restrict_public_buckets = false
}

#外部からの読み込みを許可するポリシーを設定
resource "aws_s3_bucket_policy" "public_bucket_static_contents_policy" {
  bucket = aws_s3_bucket.public_bucket_static_contents.id
  policy = <<POLICY
  {
    "Version": "2012-10-17",
    "Statement": [
      {
        "Effect": "Allow",
        "Principal": "*",
        "Action": [
          "s3:GetObject"
        ],
        "Resource": "${aws_s3_bucket.public_bucket_static_contents.arn}/*"
      }
    ]
  }
  POLICY
}