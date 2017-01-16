# == Class: admin_ceph::mon
#
# This module configures a mon server for ceph
#
# === Parameters
#
# [*fsid*]
#   fsid of ceph cluster, generate one with: uuidgen
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
# [*public_addr*]
#   Public ip of this mon-server, this is the address which clients will connect to
#
class ceph::server::mon (
  $id,
  $fsid=undef,
  $log_to_syslog=undef,
  $mon_log_file=undef,
  $public_addr=$::ipaddress
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
    require => [ Ceph::Key['mon.'], Ceph::Key['client.admin'] ],
  }

}
