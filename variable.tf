variable prefix {
  default = ""
}

variable aurora_cluster_name {
  default = null
}

variable rds_db_name {
  default = null
}

variable aurora_start_enable {
  default = true
}

variable aurora_stop_enable {
  default = true
}

variable autoscaling_schedule_info {
  default = []
}

variable ecs_shedule_start_capacity {
  default = null
}

variable start_time_cron_format {
  default = null
}

variable stop_time_cron_format {
  default = null
}

variable aurora_start_time_cron_format {
  default = null
}

variable aurora_stop_time_cron_format {
  default = null
}
