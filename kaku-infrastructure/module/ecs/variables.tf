variable name_prefix {}
variable tag_name {}
variable tag_group {}

variable vpc_id {}

variable subnet_puma_1_id {}
variable subnet_puma_2_id {}
variable sg_puma_id {}
variable image_puma {}
variable image_puma_version {}

variable subnet_node_1_id {}
variable subnet_node_2_id {}
variable sg_nodejs_id {}
variable image_nodejs {}
variable image_nodejs_version {}

variable execution_role_arn {}
variable task_role_arn {}
variable cloudwatch_log_group_arn_puma {}
variable cloudwatch_log_group_arn_nodejs {}

variable tg_puma_arn {}
variable tg_nodejs_arn {}

variable primary_db_host {}
variable db_name {}

variable db_secret_username {}
variable db_secret_password {}

variable domain_name {}

variable task_cpu_puma {}
variable task_memory_puma {}
variable task_container_memory_reservation_puma {}
variable task_container_memory_puma {}
variable task_container_cpu_puma {}
variable task_count_puma {}
variable task_health_check_grace_period_seconds_puma {}
variable service_discovery_arn {}

variable task_cpu_nodejs {}
variable task_memory_nodejs {}
variable task_container_memory_reservation_nodejs {}
variable task_container_memory_nodejs {}
variable task_container_cpu_nodejs {}
variable task_count_nodejs {}
variable task_health_check_grace_period_seconds_nodejs {}
variable public_rails_api_url {}
variable private_rails_api_url {}