<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_appautoscaling_scheduled_action.ecs_down](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/appautoscaling_scheduled_action) | resource |
| [aws_appautoscaling_scheduled_action.ecs_up](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/appautoscaling_scheduled_action) | resource |
| [aws_cloudwatch_event_rule.start_aurora](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_event_rule) | resource |
| [aws_cloudwatch_event_rule.stop_aurora](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_event_rule) | resource |
| [aws_cloudwatch_event_target.start_aurora](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_event_target) | resource |
| [aws_cloudwatch_event_target.stop_aurora](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_event_target) | resource |
| [aws_iam_role.aurora](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy.aurora](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy) | resource |
| [aws_iam_role_policy_attachment.aurora](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_ssm_document.aurora_start](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ssm_document) | resource |
| [aws_ssm_document.aurora_stop](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ssm_document) | resource |
| [aws_caller_identity.self](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_aurora_cluster_name"></a> [aurora\_cluster\_name](#input\_aurora\_cluster\_name) | n/a | `any` | `null` | no |
| <a name="input_aurora_start_enable"></a> [aurora\_start\_enable](#input\_aurora\_start\_enable) | n/a | `bool` | `true` | no |
| <a name="input_aurora_start_time_cron_format"></a> [aurora\_start\_time\_cron\_format](#input\_aurora\_start\_time\_cron\_format) | n/a | `any` | `null` | no |
| <a name="input_aurora_stop_enable"></a> [aurora\_stop\_enable](#input\_aurora\_stop\_enable) | n/a | `bool` | `true` | no |
| <a name="input_aurora_stop_time_cron_format"></a> [aurora\_stop\_time\_cron\_format](#input\_aurora\_stop\_time\_cron\_format) | n/a | `any` | `null` | no |
| <a name="input_autoscaling_schedule_info"></a> [autoscaling\_schedule\_info](#input\_autoscaling\_schedule\_info) | n/a | `list` | `[]` | no |
| <a name="input_ecs_shedule_start_capacity"></a> [ecs\_shedule\_start\_capacity](#input\_ecs\_shedule\_start\_capacity) | n/a | `any` | `null` | no |
| <a name="input_prefix"></a> [prefix](#input\_prefix) | n/a | `string` | `""` | no |
| <a name="input_rds_db_name"></a> [rds\_db\_name](#input\_rds\_db\_name) | n/a | `any` | `null` | no |
| <a name="input_start_time_cron_format"></a> [start\_time\_cron\_format](#input\_start\_time\_cron\_format) | n/a | `any` | `null` | no |
| <a name="input_stop_time_cron_format"></a> [stop\_time\_cron\_format](#input\_stop\_time\_cron\_format) | n/a | `any` | `null` | no |

## Outputs

No outputs.
<!-- END_TF_DOCS -->