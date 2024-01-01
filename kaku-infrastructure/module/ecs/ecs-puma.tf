#secret managerからDBの情報を取得
data "aws_secretsmanager_secret" "db_secret" {
  name = "rds!cluster-e7b5a68b-3639-48d1-931c-175d9de567f1"
}

data "aws_secretsmanager_secret_version" "db_secret_id" {
  secret_id = data.aws_secretsmanager_secret.db_secret.id
}

locals {
  db_secret = jsondecode(data.aws_secretsmanager_secret_version.db_secret_id.secret_string)
  username = local.db_secret.username
  password = local.db_secret.password
}

#バックエンドコンテナ用のタスク定義
resource "aws_ecs_task_definition" "task_puma" {
  family                = "${var.name_prefix}-puma"
  requires_compatibilities = ["FARGATE"]
  network_mode          = "awsvpc"
  cpu    = "${var.task_cpu_puma}"
  memory = "${var.task_memory_puma}"
  execution_role_arn    = "${var.execution_role_arn}"

  container_definitions = jsonencode([{
    name  = "kaku_puma",
    image = "${var.image_puma}",
    essential: true,
    memoryReservation = "${var.task_container_memory_reservation_puma}"
    memory = "${var.task_container_memory_puma}",
    cpu = "${var.task_container_cpu_puma}",
    portMappings: [
      {
        protocol: "tcp",
        containerPort: 80
      }
    ],
    logConfiguration = {
      logDriver = "awslogs",
      options = {
        "awslogs-group"         = "${var.cloudwatch_log_group_arn_puma}",
        "awslogs-region"        = "ap-northeast-1",
        "awslogs-stream-prefix" = "${var.name_prefix}-puma"
      }
    },
    environment = [
      {
        name  = "DATABASE_HOST",
        value = "${var.primary_db_host}"
      },
      {
        name  = "DATABASE_NAME",
        value = "${var.db_name}"
      },
      {
        name      = "DATABASE_USERNAME",
        valueFrom = local.username
      },
      {
        name      = "DATABASE_PASSWORD",
        valueFrom = local.password
      }
    ]
  }])

}

#バックエンドのecrクラスターを定義
resource "aws_ecs_cluster" "cluster_puma" {
  name = "${var.name_prefix}-puma"

  setting {
    name  = "containerInsights"
    value = "enabled"
  }
}

resource "aws_ecs_service" "service_puma" {
	name = "${var.name_prefix}-puma"
	launch_type = "FARGATE"
  platform_version = "1.4.0"

	task_definition = aws_ecs_task_definition.task_puma.arn
	desired_count = "${var.task_count_puma}"

  health_check_grace_period_seconds = "${var.task_health_check_grace_period_seconds_puma}"

	cluster = aws_ecs_cluster.cluster_puma.id

	network_configuration {
		subnets         = [var.subnet_puma_1_id, var.subnet_puma_2_id]
		security_groups = [var.sg_puma_id]
    assign_public_ip = false
	}

	load_balancer {
			target_group_arn = var.tg_puma_arn
			container_name   = "kaku_puma"
			container_port   = "80"
		}
}