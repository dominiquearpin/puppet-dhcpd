# == dhcpd::class
#
#   This defined type permits the creation of dhcp client class
#   > "DHCP Clients can be separated into classes, 
#   > and treated differently depending on what class they are in."
#
# == parameters
#
# $config_file: string to concat file (dhcpd config file)
# $math_if: regule dhcp expression for matching clients
# $filename: string to PXE boot file name
# $next_server: string to tftp server
# $order: regular concat order
# $class_cfg_prepend: allows complex configuration to be added *before* any statement
# $class_cfg_append: allows complex configuration to be added *after* any statement
#
define dhcpd::class(
$config_file        = $::dhcpd::config_file,
$match_if           = undef,
$filename           = undef,
$next_server        = undef,
$order              = 40,
$max_lease_time     = undef,
$default_lease_time = undef,
$class_cfg_prepend  = undef,
$class_cfg_append   = undef,
) {
  include dhcpd::params

  concat::fragment { "class_${name}_start":
    content => template('dhcpd/dhcpd_class_header.conf.erb'),
    target  => $config_file,
    order   => $order
  }

}
