# #対象ファイルの取得
# data "archive_file" "put_image_zip" {
#   type        = "zip"
#   source_dir  = "module/lambda/code/put-image"
#   output_path = "module/lambda/code/put-image/put-image.zip"
# }

# #Lmnbdaリソースの定義
# resource "aws_lambda_function" "put_image_function" {
#   filename         = data.archive_file.put_image_zip.output_path
#   source_code_hash = data.archive_file.put_image_zip.output_base64sha256

#   function_name    = "put-image"

#   role             = var.lambda_put_image_role_arn
#   handler          = "put-image.lambda_handler"

#   runtime          = "ruby3.2"

#   tags = {
#     Name = "${var.tag_name}-put-image"
#     Group = var.tag_group
#   }
# }


# resource "aws_lambda_function_url" "put_image" {
#   function_name = aws_lambda_function.put_image_function.function_name
#   authorization_type = "NONE"
# }