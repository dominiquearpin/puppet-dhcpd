Facter.add(:dhcpd_version) do
  confine :kernel  => :linux
  if File.exists?('/usr/sbin/dhcpd')
    setcode do
      Facter::Util::Resolution.exec("/usr/sbin/dhcpd --version 2>&1").gsub(/^.*([0-9]+\.[0-9]+\.[0-9]+).*$/, '\1')
    end
  end
end
