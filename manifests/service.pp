# Takes care of starting mcelog service
class mcelog::service {
  if $mcelog::package_ensure == 'uninstall' {
    $service_ensure_real = 'stopped'
    $service_enable_real = false
  } else {
    $service_ensure_real = $mcelog::service_ensure
    $service_enable_real = $mcelog::service_enable
  }

  service { $mcelog::params::service:
    ensure => $service_ensure_real,
    enable => $service_enable_real,
  }
}
