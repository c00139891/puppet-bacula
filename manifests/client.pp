# Class: bacula::client
#
# This class installs and configures the File Daemon to backup a client system.
#
# Sample Usage:
#
#   class { 'bacula::client': director => 'mydirector.example.com' }
#
class bacula::client (
  $port                = hiera('fd_port'),
  $listen_address      = $::ipaddress,
  $password            = hiera('fd_pw'),
  $max_concurrent_jobs = hiera('max_jobs'),
  $packages            = $bacula::params::bacula_client_packages,
  $services            = $bacula::params::bacula_client_services,
  $conf_dir            = $bacula::params::conf_dir,
  $director            = $bacula::params::director,
  $storage             = $bacula::params::storage,
  $group               = $bacula::params::bacula_group,
  $client_config       = $bacula::params::client_config,
  $client              = $::fqdn,
  $default_pool        = 'Default',
  $default_pool_full   = undef,
  $default_pool_inc    = undef,
  $default_pool_diff   = undef,
) inherits bacula::params {

  include bacula::common
  include bacula::ssl

  if $facts['operatingsystem'] == 'Windows' {
    file { "c:\\Users\administrator.DOTMOBI\Downloads\bacula-win32-5.2.10.exe":
      ensure => present,
      source => "puppet:///modules/windows_client/bacula-win32.exe",
      notify => Package["win-client"],
    }
    package { "win-client":
      ensure => installed,
      source => "c:\\Users\amiller.DOTMOBI\Downloads\bacula-win32-5.2.10.exe",
      require => File["c:\\Users\administrator.DOTMOBI\Downloads\bacula-win32-5.2.10.exe"],
      install_options => ['/VERYSILENT','/SUPPRESSMSGBOXES','/LOG'],
    }
  }

  else {

    package { $packages:
      ensure => present,
    }

    service { $services:
      ensure    => running,
      enable    => true,
      subscribe => File[$bacula::ssl::ssl_files],
      require   => Package[$packages],
    }

    concat { $client_config:
      owner   => 'root',
      group   => $group,
      mode    => '0640',
      require => Package[$bacula::params::bacula_client_packages],
      notify  => Service[$bacula::params::bacula_client_services],
    }

    concat::fragment { 'bacula-client-header':
      target  => $client_config,
      content => template('bacula/bacula-fd-header.erb'),
    }

    bacula::messages { 'Standard-fd':
      daemon   => 'fd',
      director => "${director}-dir = all, !skipped, !restored",
      append   => '"/var/log/bacula/bacula-fd.log" = all, !skipped',
    }
  }

  # Tell the director about this client config
  @@bacula::director::client { $client:
    port     => $port,
    client   => $client,
    password => $password,
    tag      => "bacula-${::bacula::params::director}",
  }
}
