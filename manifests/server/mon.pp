# == Class: admin_ceph::mon
#
# This module configures a mon server for ceph
#
# === Parameters
#

class ceph::server::mon ($id){

  concat::fragment { "/etc/ceph/ceph.conf-mon":
    target  => '/etc/ceph/ceph.conf',
    content => template("${module_name}/ceph.conf-mon.erb"),
    order   => 2,
  }
}
