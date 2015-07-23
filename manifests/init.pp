# Class: mcelog
#
# This module manages mcelog
#
# === Parameters:
# $version::                    pulp package version, it's passed to ensure parameter of package resource
#                               can be set to specific version number, 'latest', 'present' etc.
#
# $service_ensure::             if the service should be running or stopped
#
# $service_enable::             if the service should be enabled or not
#
# $skip_virtual::               if true, don't do anything on virtual machines
#
# $no_imc_log::                 by default, disable extended error logging on newer Intel processors
#
# $cpu::                        Set CPU type for which mcelog decodes events
#
# $daemon::                     By default mcelog just processes the currently pending events and exits.
#                               in daemon mode it will keep running as a daemon in the background and poll
#                               the kernel for events and then decode them.
#
# $filter::                     Filter out known broken events by default
#
# $filter_memory_errors::       don't log memory errors individually
#                               they still get accounted if that is enabled
#
# $raw::                        output in undecoded raw format to be easier machine readable
#                               (default is decoded)
#
# $syslog::                     Log decoded machine checks in syslog (default stdout or syslog for daemon)
#
# $syslog_error::               Log decoded machine checks in syslog with error level
#
# $no_syslog::                  Never log anything to syslog
#
# $logfile::                    Append log output to logfile instead of stdout. Only when no syslog logging is active
#
# $run_credentials_user::       when in daemon mode run as this user after set up
#                               note that the triggers will run as this user too
#                               setting this to non root will mean that triggers cannot take some corrective
#                               action, like offlining objects
#
class mcelog (
  $version              = $mcelog::params::version,
  $service_ensure       = $mcelog::params::service_ensure,
  $service_enable       = $mcelog::params::service_enable,
  $skip_virtual         = $mcelog::params::skip_virtual,
  $no_imc_log           = $mcelog::params::no_imc_log,
  $cpu                  = $mcelog::params::cpu,
  $daemon               = $mcelog::params::daemon,
  $filter               = $mcelog::params::filter,
  $filter_memory_errors = $mcelog::params::filter_memory_errors,
  $raw                  = $mcelog::params::raw,
  $syslog               = $mcelog::params::syslog,
  $syslog_error         = $mcelog::params::syslog_error,
  $no_syslog            = $mcelog::params::no_syslog,
  $logfile              = $mcelog::params::logfile,
  $run_credentials_user = $mcelog::params::run_credentials_user,
) inherits mcelog::params {
  validate_bool($skip_virtual)

  if !($::is_virtual and $skip_virtual) {
    contain mcelog::install
    contain mcelog::config
    contain mcelog::service

    Class['mcelog::install'] ->
    Class['mcelog::config'] ~>
    Class['mcelog::service']
  }
}
