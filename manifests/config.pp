# == Class: ceph::config
#
# This module configures stuff common to all ceph hosts
#

class ceph::config {

  $mon_hosts   = $::ceph::mon_hosts
  $cluster_net = $::ceph::cluster_net
  $public_net  = $::ceph::public_net

  file { [ '/etc/ceph' ]:
    ensure  => directory,
    owner   => 'root',
    group   => 'nagios',
    mode    => '0640',
    require => Package['nagios-nrpe-server'],
  }

  concat { '/etc/ceph/ceph.conf':
  }

  concat::fragment { 'ceph-main':
    target  => '/etc/ceph/ceph.conf',
    content => template("${module_name}/ceph.conf-main.erb"),
    order   => '0001',
  }

  concat { '/etc/ceph/keyring':
  }
}
