# Class: bacula::params
#
# Set some platform specific paramaters.
#
class bacula::params {

  $file_retention = '45 days'
  $job_retention  = '6 months'
  $autoprune      = 'yes'
  $monitor        = true
  $ssl            = hiera('bacula::params::ssl', false)
  $ssl_dir        = hiera('bacula::params::ssl_dir', '/etc/puppetlabs/puppet/ssl')
  $dir_port       = hiera('bacula::params::dir_port')
  $dir_pw         = hiera('bacula::params::dir_pw')
  $max_jobs       = hiera('bacula::params::max_jobs')
  $fd_port        = hiera('bacula::params::fd_port')
  $fd_pw          = hiera('bacula::params::fd_pw')
  $sd_port        = hiera('bacula::params::sd_port')
  $sd_pw          = hiera('bacula::params::sd_pw')
  $db_pw          = hiera('bacula::params::db_pw')

  validate_bool($ssl)

  if $facts['operatingsystem'] in ['RedHat', 'CentOS', 'Fedora', 'Scientific'] {
    $db_type        = hiera('bacula::params::db_type', 'postgresql')
  } else {
    $db_type        = hiera('bacula::params::db_type', 'pgsql')
  }

  $storage          = hiera('bacula::params::storage', $::fqdn)
  $director         = hiera('bacula::params::director', $::fqdn)
  $director_address = hiera('bacula::params::director_address', $director)
  $job_tag          = hiera('bacula::params::job_tag', '')

  case $facts['operatingsystem'] {
    'Ubuntu','Debian': {
      $bacula_director_packages = [ 'bacula-director-common', "bacula-director-${db_type}", 'bacula-console' ]
      $bacula_director_services = [ 'bacula-director' ]
      $bacula_storage_packages  = [ 'bacula-sd', "bacula-sd-${db_type}" ]
      $bacula_storage_services  = [ 'bacula-sd' ]
      $bacula_client_packages   = 'bacula-client'
      $bacula_client_services   = 'bacula-fd'
      $conf_dir                 = '/etc/bacula'
      $bacula_dir               = '/etc/bacula/ssl'
      $client_config            = '/etc/bacula/bacula-fd.conf'
      $homedir                  = '/var/lib/bacula'
      $rundir                   = '/var/run/bacula'
      $bacula_user              = 'bacula'
      $bacula_group             = $bacula_user
    }
    'SLES': {
      $bacula_director_packages = [ 'bacula-director-common', "bacula-director-${db_type}", 'bacula-console' ]
      $bacula_director_services = [ 'bacula-dir' ]
      $bacula_storage_packages  = [ 'bacula-sd', "bacula-sd-${db_type}" ]
      $bacula_storage_services  = [ 'bacula-sd' ]
      $bacula_client_packages   = 'bacula-client'
      $bacula_client_services   = 'bacula-fd'
      $conf_dir                 = '/etc/bacula'
      $bacula_dir               = '/etc/bacula/ssl'
      $client_config            = '/etc/bacula/bacula-fd.conf'
      $homedir                  = '/var/lib/bacula'
      $rundir                   = '/var/run'
      $bacula_user              = 'bacula'
      $bacula_group             = $bacula_user
    }
    'RedHat','CentOS','Fedora','Scientific': {
      if 0 + $facts['operatingsystemmajrelease'] < 7 or ($facts['operatingsystem'] == 'Fedora' and 0 + $facts['operatingsystemmajrelease'] < 17) {
        $bacula_director_packages = [ 'bacula-director-common', "bacula-director-${db_type}", 'bacula-console' ]
        $bacula_storage_packages  = [ 'bacula-storage-common', "bacula-storage-${db_type}" ]
      } else {
        $bacula_director_packages = [ 'bacula-director', 'bacula-console' ]
        $bacula_storage_packages  = [ 'bacula-storage' ]
      }
      $bacula_director_services = [ 'bacula-dir' ]
      $bacula_storage_services  = [ 'bacula-sd' ]
      $bacula_client_packages   = 'bacula-client'
      $bacula_client_services   = 'bacula-fd'
      $conf_dir                 = '/etc/bacula'
      $bacula_dir               = '/etc/bacula/ssl'
      $client_config            = '/etc/bacula/bacula-fd.conf'
      $homedir                  = '/var/spool/bacula'
      $rundir                   = '/var/run'
      $bacula_user              = 'bacula'
      $bacula_group             = $bacula_user
    }
    'FreeBSD': {
      $bacula_director_packages = [ 'bacula-server' ]
      $bacula_director_services = [ 'bacula-dir' ]
      $bacula_storage_packages  = [ 'bacula-server' ]
      $bacula_storage_services  = [ 'bacula-sd' ]
      $bacula_client_packages   = 'sysutils/bacula-client'
      $bacula_client_services   = 'bacula-fd'
      $conf_dir                 = '/usr/local/etc/bacula'
      $bacula_dir               = '/usr/local/etc/bacula/ssl'
      $client_config            = '/usr/local/etc/bacula/bacula-fd.conf'
      $rundir                   = '/var/run'
      $homedir                  = '/var/db/bacula'
      $bacula_user              = 'bacula'
      $bacula_group             = 'bacula'
      $webacula_conf            = '/usr/local/etc/httpd/conf.d/webacula.conf'
      $webacula_dir             = '/usr/share/webacula/html'
      $webacula_user_auth       = "/usr/local/etc/httpd/conf/webacula.users"
      $webacula_index           = "/usr/share/webacula/html/index.php"
      $webacula_pkgs            = [
                                   'webacula',
                                   'php-ZendFramework-Db-Adapter-Pdo-Mysql',
                                  ]
    }
    'OpenBSD': {
      $bacula_director_packages = [ 'bacula-server', "bacula-${db_type}" ]
      $bacula_director_services = [ 'bacula_dir' ]
      $bacula_storage_packages  = [ 'bacula-server', "bacula-${db_type}" ]
      $bacula_storage_services  = [ 'bacula_sd' ]
      $bacula_client_packages   = 'bacula-client'
      $bacula_client_services   = 'bacula_fd'
      $conf_dir                 = '/etc/bacula'
      $bacula_dir               = '/etc/bacula/ssl'
      $client_config            = '/etc/bacula/bacula-fd.conf'
      $rundir                   = '/var/run'
      $homedir                  = '/var/bacula'
      $bacula_user              = '_bacula'
      $bacula_group             = '_bacula'
    }
    'windows': {
      $client_name		= "%{hiera('client_name')}"
      $client_addr		= "%{hiera('client_addr')}"
      $client_port		= "%{hiera('client_port')}"
      $client_catalog           = "%{hiera('client_catalog')}"
      $client_pw		= "%{hiera('client_pw')}"
      $client_working_path	= "%{hiera('client_working_path')}"
      $client_pid_path		= "%{hiera('client_pid_path')}"
      $client_plugin_path	= "%{hiera('client_plugin_path')}"
      $bacula_client_packages	= 'bacula_win_client'
      $bacula_client_services   = 'bacula_fd'
      $client_conf		= "%{hiera('client_conf')}"
    }
    default: { fail("bacula::params has no love for ${facts['operatingsystem']}") }
  }

  $certfile = "${conf_dir}/ssl/${::clientcert}_cert.pem"
  $keyfile  = "${conf_dir}/ssl/${::clientcert}_key.pem"
  $cafile   = "${conf_dir}/ssl/ca.pem"
}
