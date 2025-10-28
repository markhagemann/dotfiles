{ host, ... }: ''
  // Monitor configuration for desktop
  // Uncomment the outputs below when you want to use this configuration

  // Right monitor
  output "DP-1" {
      mode "2560x1440@239.970"
      scale 1.0
      transform "normal"
  }

  // Left monitor
  output "DP-2" {
      mode "2560x1440@359.979"
      scale 1.0
      transform "normal"
  }
''
