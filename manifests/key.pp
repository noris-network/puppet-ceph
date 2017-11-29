# == Class: ceph::key
#
# This module creates a key in /etc/ceph/keyring
#
# === Parameters
#
# [*key*]
#   This is the key
#
# [*caps_mds*]
# [*caps_mon*]
# [*caps_osd*]
#

define ceph::key (
    $key,
    $auid = undef,
    $caps_mds = undef,
    $caps_mon = undef,
    $caps_osd = undef
    ){
  if $title == 'client.admin' {
    $_auid = 0
    $_caps_mds = 'allow'
    $_caps_mon = 'allow *'
    $_caps_osd = 'allow *'
  } else {
    $_auid = $auid
    $_caps_mds = $caps_mds
    $_caps_mon = $caps_mon
    $_caps_osd = $caps_osd
  }
  concat::fragment { "/etc/ceph/keyring-${title}":
    target  => '/etc/ceph/keyring',
    content => template("${module_name}/key.erb"),
    order   => 2,
  }
}
