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
  
  if $mcelog::delete_mcelog_setup {
    file { '/etc/mcelog/mcelog.setup': ensure => 'absent', }
  }
}
