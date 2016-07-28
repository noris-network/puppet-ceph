# == Class: admin_ceph::mon
#
# This module configures a mon server for ceph
#
# === Parameters
#
# [*id*]
#   The id of this monitor.
#
# [*log_to_syslog*]
#   Enable logging to syslog
#
# [*mon_log_file*]
#   Location of logfile
#
class ceph::server::mon (
  $id,
  $fsid=undef,
  $log_to_syslog=undef,
  $mon_log_file=undef
  ){

  host { $::fqdn:
    ip           => $::ipaddress,
    host_aliases => $::hostname,
  }

  concat::fragment { '/etc/ceph/ceph.conf-mon':
    target  => '/etc/ceph/ceph.conf',
    content => template("${module_name}/ceph.conf-mon.erb"),
    order   => 2,
  }

  file { "/var/lib/ceph/mon/ceph-${id}" :
    ensure => directory,
    mode   => '0750',
    owner  => 'ceph',
    group  => 'ceph',
  }

  exec { "createmon-${id}":
    user    => 'ceph',
    command => "/usr/bin/ceph-mon --mkfs -i ${id} --fsid ${fsid} --keyring /etc/ceph/keyring",
    creates => "/var/lib/ceph/mon/ceph-${id}/keyring",
    require => [ Ceph::Key['mon.'], Ceph::Key['client.admin'] ]
  }

}
