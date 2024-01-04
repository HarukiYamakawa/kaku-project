resource "aws_iam_policy" "ecs_task_execution_role_policy" {
  name = "${var.name_prefix}-ecs-task-execution-role-policy"

  policy = jsonencode({
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "ecr:GetAuthorizationToken",
                "ecr:BatchCheckLayerAvailability",
                "ecr:GetDownloadUrlForLayer",
                "ecr:BatchGetImage",
                "logs:CreateLogStream",
                "logs:PutLogEvents",
                "secretsmanager:GetSecretValue",
                "secretsmanager:DescribeSecret"
            ],
            "Resource": "*"
        }
    ]
})
}

resource "aws_iam_role" "ecs_task_execution_role" {
  name = "${var.name_prefix}-ecs-task-execution-role"

  assume_role_policy = jsonencode({
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "",
            "Effect": "Allow",
            "Principal": {
                "Service": [
                    "ecs-tasks.amazonaws.com"
                ]
            },
            "Action": "sts:AssumeRole"
        }
    ]
})
}

resource "aws_iam_role_policy_attachment" "ecs_task_execution_role_attach" {
  role       = aws_iam_role.ecs_task_execution_role.name
  policy_arn = aws_iam_policy.ecs_task_execution_role_policy.arn
}

resource "aws_iam_policy" "ecs_task_role_policy" {
  name = "${var.name_prefix}-ecs-task-role-policy"

  policy = jsonencode({
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "ssmmessages:CreateControlChannel",
                "ssmmessages:CreateDataChannel",
                "ssmmessages:OpenControlChannel",
                "ssmmessages:OpenDataChannel"
            ],
            "Resource": "*"
        }
    ]
})
}

resource "aws_iam_role" "ecs_task_role" {
  name = "${var.name_prefix}-ecs-task-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = "sts:AssumeRole",
        Effect = "Allow",
        Principal = {
          Service = "ecs-tasks.amazonaws.com"
        }
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "ecs_task_role_attach" {
  role       = aws_iam_role.ecs_task_role.name
  policy_arn = aws_iam_policy.ecs_task_role_policy.arn
}


# resource "aws_iam_role" "lambda_put_image_role" {
#   name = "${var.name_prefix}-put-image"

#   assume_role_policy = jsonencode({
#     Version = "2012-10-17",
#     Statement = [{
#       Action = "sts:AssumeRole",
#       Effect = "Allow",
#       Principal = {
#         Service = "lambda.amazonaws.com"
#       },
#     }]
#   })
# }

# #S3へのアクセス権限を付与
# resource "aws_iam_policy" "lambda_put_image_role_policy" {
#   name = "${var.name_prefix}-put-image"

#   policy = jsonencode({
#     Version = "2012-10-17",
#     Statement = [{
#       Action = [
#         "s3:PutObject",
#         "s3:GetObject"
#       ],
#       Effect = "Allow",
#       Resource = [
#         "${var.static_contents_bucket_arn}",
#         "${var.static_contents_bucket_arn}/*"
#       ]
#     },
#     {
#       Action = [
#         "logs:CreateLogGroup",
#         "logs:CreateLogStream",
#         "logs:PutLogEvents"
#       ],
#       Effect = "Allow",
#       Resource = "*"
#     }
#     ]
#   })
# }

# resource "aws_iam_role_policy_attachment" "lambda_put_image_role_attach" {
#   role       = aws_iam_role.lambda_put_image_role.name
#   policy_arn = aws_iam_policy.lambda_put_image_role_policy.arn
# }