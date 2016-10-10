define bacula::director::client (
  $port           = "%{hiera('client_port')}",
  $client         = $::fqdn,
  $password       = "%{hiera('client_pw')}",
  $conf_dir       = $bacula::params::conf_dir, # Overridden at realize
  $file_retention = $bacula::params::file_retention,
  $job_retention  = $bacula::params::job_retention,
  $autoprune      = $bacula::params::autoprune,
) {

  concat::fragment { "bacula-director-client-${client}":
    target  => "${conf_dir}/conf.d/client.conf",
    content => template('bacula/bacula-dir-client.erb'),
  }
}
