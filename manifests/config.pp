# configures mcelog
class mcelog::config {
  if $mcelog::package_ensure == 'absent' {
    $file_ensure = $mcelog::package_ensure
  } else {
    $file_ensure = 'file'
  }

  file { '/etc/mcelog/mcelog.conf':
    ensure  => $file_ensure,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    content => template("${module_name}/mcelog.conf.erb"),
  }

  if $::operatingsystemmajrelease == 7 {
    file { '/etc/systemd/system/mcelog.service':
      ensure  => $file_ensure,
      owner   => 'root',
      group   => 0,
      mode    => '0644',
      content => template("${module_name}/mcelog.service"),
    } ~>
    exec { 'mcelog refresh system service':
      command     => '/bin/systemctl daemon-reload',
      refreshonly => true,
    }
  }
}
