define dhcpd::host(
$config_file        = $::dhcpd::config_file,
$hardware_type      = undef,
$hardware_address   = undef,
$fixed_address      = undef,
$order              = '03',
) {
  include dhcpd::params

  concat::fragment { "host_${title}_start":
    content => template('dhcpd/dhcpd_host_header.conf.erb'),
    target  => $config_file,
    order   => $order
  }

}
