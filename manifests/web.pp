class bacula::web (
  $db_user	= $bacula::params::bacula_user,
  $db_pw	= $bacula::params::dir_db_pw,
  $db_name	= $bacula::params::bacula_user,
  $db_type	= $bacula::param::db_type,
) {

  nginx_dotmobi::file { 'nginx.conf' :
    source => 'puppet:///modules/bacula/nginx.conf.erb',
  }

  include php_fpm

  file { 'install_production.sh':
    ensure => 'file',
    source => 'puppet:///modules/puppet-bacula/files/install_production.sh',
    path => '/usr/local/etc/puppet/modules/puppet-bacula/install_production.sh',
    owner => 'root',
    group => 'root',
    mode  => '0700', # Use 0700 if it is sensitive
    notify => Exec['run_install_production'],
  }
  exec { 'run_install_production':
    command => '/usr/local/etc/puppet/modules/puppet-bacula/install_production.sh',
    refreshonly => true
  }
}  
