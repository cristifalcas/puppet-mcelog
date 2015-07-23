# Installs default mcelog packages
class mcelog::install {
  package { 'mcelog': ensure => $mcelog::package_ensure, }
}
