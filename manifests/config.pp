# configures mcelog
class mcelog::config {
  if $mcelog::version == 'absent' {
    $file_ensure = 'absent'
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

  if $::operatingsystemmajrelease == '7' and $mcelog::delete_mcelog_setup {
    file { '/etc/mcelog/mcelog.setup':
      ensure  => $file_ensure,
      owner   => 'root',
      group   => 'root',
      mode    => '0755',
      content => "#!/bin/sh\n#Managed by puppet\nexit 0\n",
    }
  }
}
