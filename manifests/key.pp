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
  if $title == 'client.admin' {
    $_auid = 0
    $_caps_mds = 'allow'
    $_caps_mon = 'allow *'
    $_caps_osd = 'allow *'
  }
  concat::fragment { "/etc/ceph/keyring-${title}":
    target  => '/etc/ceph/keyring',
    content => template("${module_name}/key.erb"),
    order   => 2,
  }
}
