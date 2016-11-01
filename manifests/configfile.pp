# == Class: dhcpd::configfile
#
# Manage additional hcp config file and add it to the main config file
#
# === Parameters
#
# [*config_file*]
#   specify the main config file to add the include into
#
# === Examples
#
#  dhcpd::configfile { '/etc/dhcp/printers.conf':
#  }
#
# === Authors
#
# David Barbion <dbarbion@gmail.com>
#
define dhcpd::configfile(
$config_file       = $::dhcpd::config_file,
) {
  include dhcpd::params

  validate_string($config_file)

  concat { $title:
    owner  => 'root',
    group  => 'root',
    mode   => '0644',
    notify => Service[$::dhcpd::params::service_name],
  }

  $config_name = regsubst($title, '(\s|/)', '_', 'G')

  concat::fragment { "configfile${config_name}_header":
    content => template('dhcpd/configfile_header.conf.erb'),
    target  => $title,
    order   => 10
  }

  concat::fragment { "configfile${config_name}_footer":
    content => template('dhcpd/configfile_footer.conf.erb'),
    target  => $title,
    order   => 50
  }

  concat::fragment { "dhcpd_include${config_name}":
    content => "include \"${title}\";",
    target  => $config_file,
  }
}
