# Installs default mcelog packages
class mcelog::install {
  package { 'mcelog': ensure => $mcelog::version, }
}
