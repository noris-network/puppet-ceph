# == Class: ceph::key
#
# This module creates a key in /etc/ceph/keyring
#
# === Parameters
#
# [*key*]
#   This is the key
#

define ceph::key ($key){
  concat::fragment { "/etc/ceph/keyring-${title}":
    target  => '/etc/ceph/keyring',
    content => template("${module_name}/key.erb"),
    order   => 2,
  }
}
