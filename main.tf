data aws_caller_identity self {}

resource aws_ssm_document aurora_stop {
  count = var.aurora_cluster_name != null ? 1 : 0

  name            = format("%sAuroraStopAutomation", var.prefix)
  document_type   = "Automation"
  document_format = "YAML"
  content         = file("${path.module}/documents/aurora_stop")
}

resource aws_ssm_document aurora_start {
  count = var.aurora_cluster_name != null ? 1 : 0

  name            = format("%sAuroraStartAutomation", var.prefix)
  document_type   = "Automation"
  document_format = "YAML"
  content         = file("${path.module}/documents/aurora_start")
}


# CloudWatch Event
resource aws_cloudwatch_event_rule stop_aurora {
  count      = var.aurora_cluster_name != null && var.stop_time_cron_format != null ? 1 : 0
  name       = format("%sAuroraStop", var.prefix)
  is_enabled = var.aurora_stop_enable

  schedule_expression = var.stop_time_cron_format
}

resource aws_cloudwatch_event_target stop_aurora {
  count     = var.aurora_cluster_name != null && var.stop_time_cron_format != null ? 1 : 0
  target_id = format("%sAuroraStop", var.prefix)
  arn       = format("arn:aws:ssm:ap-northeast-1:%s:automation-definition/%s:$DEFAULT", data.aws_caller_identity.self.account_id, element(concat(aws_ssm_document.aurora_stop.*.name, [""]), 0))
  rule      = element(concat(aws_cloudwatch_event_rule.stop_aurora.*.name, [""]), 0)
  role_arn  = element(concat(aws_iam_role.aurora.*.arn, [""]), 0)

  input = "{ \"ClusterId\": [\"${var.aurora_cluster_name}\"]}"

  depends_on = [
    aws_ssm_document.aurora_stop,
    aws_cloudwatch_event_rule.stop_aurora,
    aws_iam_role.aurora
  ]
}

resource aws_cloudwatch_event_rule start_aurora {
  count      = var.aurora_cluster_name != null && var.start_time_cron_format != null ? 1 : 0
  name       = format("%sAuroraStart", var.prefix)
  is_enabled = var.aurora_start_enable

  schedule_expression = var.start_time_cron_format
}

resource aws_cloudwatch_event_target start_aurora {
  count     = var.aurora_cluster_name != null && var.start_time_cron_format != null ? 1 : 0
  target_id = format("%sAuroraStart", var.prefix)
  arn       = format("arn:aws:ssm:ap-northeast-1:%s:automation-definition/%s:$DEFAULT", data.aws_caller_identity.self.account_id, element(concat(aws_ssm_document.aurora_start.*.name, [""]), 0))
  rule      = element(concat(aws_cloudwatch_event_rule.start_aurora.*.name, [""]), 0)
  role_arn  = element(concat(aws_iam_role.aurora.*.arn, [""]), 0)

  input = "{ \"ClusterId\": [\"${var.aurora_cluster_name}\"]}"

  depends_on = [
    aws_ssm_document.aurora_start,
    aws_cloudwatch_event_rule.start_aurora,
    aws_iam_role.aurora
  ]
}

# IAM Role
resource aws_iam_role aurora {
  count = var.aurora_cluster_name != null ? 1 : 0

  name = format("%sAuroraAutomationRole", var.prefix)

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": [
         "events.amazonaws.com"
         ]
     },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

resource aws_iam_role_policy aurora {
  count = var.aurora_cluster_name != null ? 1 : 0

  name = format("%sAuroraAutomationPolicy", var.prefix)
  role = element(concat(aws_iam_role.aurora.*.id, [""]), 0)

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "",
      "Effect": "Allow",
      "Action": [
        "rds:StopDBCluster",
        "rds:StartDBCluster",
        "rds:DescribeDBClusters"
      ],
      "Resource": "*"
    }
  ]
}
EOF

  depends_on = [
    aws_iam_role.aurora
  ]
}

resource aws_iam_role_policy_attachment aurora {
  count      = var.aurora_cluster_name != null ? 1 : 0
  role       = element(concat(aws_iam_role.aurora.*.id, [""]), 0)
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonSSMAutomationRole"

  depends_on = [
    aws_iam_role.aurora
  ]
}

resource aws_appautoscaling_scheduled_action ecs_down {
  for_each           = {for s in var.autoscaling_schedule_info: s.resource_id => s}
  name               = format("%sECSScheduleDown", var.prefix)
  service_namespace  = lookup(each.value, "service_namespace")
  resource_id        = lookup(each.value, "resource_id")
  scalable_dimension = lookup(each.value, "scalable_dimension")
  schedule           = lookup(each.value, "stop_time_cron_format", var.stop_time_cron_format)

  scalable_target_action {
    min_capacity = 0
    max_capacity = 0
  }
}

resource aws_appautoscaling_scheduled_action ecs_up {
  for_each           = {for s in var.autoscaling_schedule_info: s.resource_id => s}
  name               = format("%sECSScheduleUp", var.prefix)
  service_namespace  = lookup(each.value, "service_namespace")
  resource_id        = lookup(each.value, "resource_id")
  scalable_dimension = lookup(each.value, "scalable_dimension")
  schedule           = lookup(each.value, "start_time_cron_format", var.start_time_cron_format)

  scalable_target_action {
    min_capacity = var.ecs_shedule_start_capacity["min"]
    max_capacity = var.ecs_shedule_start_capacity["max"]
  }
}
