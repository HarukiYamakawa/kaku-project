variable name_prefix {
  default = "kaku"
}

variable tag_name {
  default = "kaku"
}

variable tag_group {
  default = "kaku"
}

# pumaのタスク定義用
variable image_puma {
  default = "851521956361.dkr.ecr.ap-northeast-1.amazonaws.com/kaku-puma:v2"
}
variable task_cpu_puma {
  default = 256
}
variable task_memory_puma {
  default = 512
}
variable task_container_memory_reservation_puma {
  default = 512
}
variable task_container_memory_puma {
  default = 512
}
variable task_container_cpu_puma {
  default = 256
}
variable task_count_puma {
  default = 1
}
variable task_health_check_grace_period_seconds_puma {
  default = 60
}