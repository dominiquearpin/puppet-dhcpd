# == Class: dhcpd::params
#
# Params for dhcpd modules
#
# === Authors
#
# David Barbion <dbarbion@gmail.com>
#
class dhcpd::params {
  case $::osfamily {
    redhat: {
      $package_name = 'dhcp'
      $service_name = 'dhcpd'
      # Hack for facter < 1.7
      $_os = pick($::operatingsystemmajrelease,
           regsubst($::operatingsystemrelease, '^([0-9]+).*', '\1'))
      case $_os {
        3,4,5: {
          $config_file  = '/etc/dhcpd.conf'
        }
        6,7: {
          $config_file  = '/etc/dhcp/dhcpd.conf'
        }
        default: {
          fail('os version not supported')
        }
      }
    }
    default: { fail('osfamily not supported') }
  }
}
