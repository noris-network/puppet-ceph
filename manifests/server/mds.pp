# == Class: ceph::server::mds
#
# This module configures an mds server for ceph
#
# === Parameters
#
# [*id*]
#   The id of this mds.
#
class ceph::server::mds (
  $id,
  $cache_size = undef,
  ){

  concat::fragment { '/etc/ceph/ceph.conf-mds':
    target  => '/etc/ceph/ceph.conf',
    content => template("${module_name}/ceph.conf-mds.erb"),
    order   => 2,
  }
}
