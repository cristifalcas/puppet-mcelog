# Class: mcelog
#
# This module manages mcelog
#
# Parameters: none
#
# Actions:
#
# Requires: see Modulefile
#
# Sample Usage:
#
class mcelog (
  $package_ensure = $mcelog::params::package_ensure,
  $service_ensure = $mcelog::params::service_ensure,
  $service_enable = $mcelog::params::service_enable,
) inherits mcelog::params {
  contain mcelog::install
  contain mcelog::config
  contain mcelog::service

  Class['mcelog::install'] ->
  Class['mcelog::config'] ~>
  Class['mcelog::service']
}
