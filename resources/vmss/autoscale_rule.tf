resource "azurerm_monitor_autoscale_setting" "scale_set" {
  name                = "${var.environment}-vmss-autoscale-setting"
  resource_group_name = azurerm_resource_group.scale_set.name
  location            = var.location
  target_resource_id  = azurerm_virtual_machine_scale_set.scale_set.id

  profile {
    name = "UpHours"

    capacity {
      default = 1
      minimum = 1
      maximum = 3
    }

    rule {
      metric_trigger {
        metric_name        = "Percentage CPU"
        metric_resource_id = azurerm_virtual_machine_scale_set.scale_set.id
        time_grain         = "PT1M"
        statistic          = "Average"
        time_window        = "PT5M"
        time_aggregation   = "Average"
        operator           = "GreaterThan"
        threshold          = 75
      }

      scale_action {
        direction = "Increase"
        type      = "ChangeCount"
        value     = "1"
        cooldown  = "PT1M"
      }
    }

    rule {
      metric_trigger {
        metric_name        = "Percentage CPU"
        metric_resource_id = azurerm_virtual_machine_scale_set.scale_set.id
        time_grain         = "PT1M"
        statistic          = "Average"
        time_window        = "PT5M"
        time_aggregation   = "Average"
        operator           = "LessThan"
        threshold          = 25
      }

      scale_action {
        direction = "Decrease"
        type      = "ChangeCount"
        value     = "2"
        cooldown  = "PT1M"
      }
    }

    recurrence {
      timezone  = var.timezone
      days      = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday" "Sunday"]
      hours     = [var.up_hour]
      minutes   = [var.up_minute]
    }
  }

 profile {
    name = "DownHours"

    capacity {
      default = 0
      minimum = 0
      maximum = 0
    }

    # rule {
    #   metric_trigger {
    #     metric_name        = "Percentage CPU"
    #     metric_resource_id = azurerm_virtual_machine_scale_set.scale_set.id
    #     time_grain         = "PT1M"
    #     statistic          = "Average"
    #     time_window        = "PT5M"
    #     time_aggregation   = "Average"
    #     operator           = "GreaterThan"
    #     threshold          = 95
    #   }

    #   scale_action {
    #     direction = "Increase"
    #     type      = "ChangeCount"
    #     value     = "1"
    #     cooldown  = "PT1M"
    #   }
    # }
    recurrence {
      timezone  = var.timezone
      days      = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday" "Sunday"]
      hours     = [var.down_hour]
      minutes   = [var.down_minute]
    }
  }
}

