variable name_prefix {
  default = "kaku"
}

variable tag_name {
  default = "kaku"
}

variable tag_group {
  default = "kaku"
}

variable service_discovery_sub_domain_name {
  default = "puma"
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
  default = 0
}
variable task_health_check_grace_period_seconds_puma {
  default = 60
}

variable service_discovery_domain_name {
  default = "kaku.local"
}

# nodejsのタスク定義用
variable image_nodejs {
  default = "851521956361.dkr.ecr.ap-northeast-1.amazonaws.com/kaku-nodejs:v2"
}
variable task_cpu_nodejs {
  default = 256
}
variable task_memory_nodejs {
  default = 512
}
variable task_container_memory_reservation_nodejs {
  default = 512
}
variable task_container_memory_nodejs {
  default = 512
}
variable task_container_cpu_nodejs {
  default = 256
}
variable task_count_nodejs {
  default = 0
}
variable task_health_check_grace_period_seconds_nodejs {
  default = 120
}

