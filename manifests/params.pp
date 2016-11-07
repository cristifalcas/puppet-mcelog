# Default parameters for mcelog module
class mcelog::params {
  $version        = 'latest'
  $service_ensure = 'running'
  $service_enable = true
  $skip_virtual   = true

  $no_imc_log     = 'yes'
  $cpu            = undef
  $daemon         = 'yes'
  $filter         = 'yes'
  $filter_memory_errors = 'yes'
  $raw            = 'no'
  $syslog         = 'yes'
  $syslog_error   = 'yes'
  $no_syslog      = 'no'
  $logfile        = 'mcelog.log'
  $run_credentials_user = 'root'

  case $::operatingsystemmajrelease {
    '6'     : {
      $service = 'mcelogd'
      $delete_mcelog_setup = undef
    }
    '7'     : {
      $service = 'mcelog'
      $delete_mcelog_setup = false
    }
    default : {
    }
  }
}
