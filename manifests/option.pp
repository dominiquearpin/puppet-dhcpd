# == dhcpd::option
#
# This defined type allow definition of custom options
# The main reason to use this instead of global config options hash
# is to force options order
#
# == Parameters
#
#  $config_file: string to concat file
#  $order: regular placement over dhcpd.conf (default: 03, after global options)
#  $sub_order: sub order placing starting from 10
#  $value: value to set for the option, maybe array or string
#
# == example
# dhcpd::option { 'client-arch':
#   value     => 'code 93 = unsigned integer 16',
#   sub_order => '10',
# }
# dhcpd::option { 'space':
#   value     => 'ipxe',
#   sub_order => '20',
# }
# dhcpd::option { 'ipxe.fcoe':
#   value     => 'code 37 = unsigned integer 8',
#   sub_order => '30',
# }
# dhcpd::option { 'ipxe.no-pxedhcp':
#   value     => 'code 176 = unsigned integer 8',
#   sub_order => '40',
# }

define dhcpd::option(
$config_file = $::dhcpd::config_file,
$order       = 30,
$sub_order   = '10',
$value,
) {
  include dhcpd::params

  concat::fragment { "${sub_order}_option_${name}":
    content => template('dhcpd/dhcpd_option.conf.erb'),
    target  => $config_file,
    order   => $order
  }

}
