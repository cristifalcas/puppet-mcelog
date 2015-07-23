# Default parameters for mcelog module
class mcelog::params {
  $package_ensure = 'latest'
  $service_ensure = 'running'
  $service_enable = true

  case $::operatingsystemmajrelease {
    '6'     : { $service = 'mcelogd' }
    '7'     : { $service = 'mcelog' }
    default : { }
  }
}
