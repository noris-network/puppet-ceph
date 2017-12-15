# == Class: admin_ceph::mgr
#
# This module configures a mgr server for ceph
#
# === Parameters
#
# [*id*]
#   The id of this mgr.
#
class ceph::server::mgr (
  $id,
  ){

  file { "/var/lib/ceph/mgr":
    ensure => directory,
    mode   => '0750',
    owner  => 'ceph',
    group  => 'ceph',
  } ->

  file { "/var/lib/ceph/mgr/ceph-${id}" :
    ensure => directory,
    mode   => '0750',
    owner  => 'ceph',
    group  => 'ceph',
  } ->

  file { "/var/lib/ceph/mgr/ceph-${id}/sysvinit":
    ensure => present,
    mode => '0400',
    owner => 'ceph',
    group => 'ceph',
  } ->

  exec { "createmgr-${id}":
    user    => 'ceph',
    command => "/usr/bin/ceph auth get-or-create mgr.${id} mon 'allow profile mgr' osd 'allow *' mds 'allow *' > /var/lib/ceph/mgr/ceph-${id}/keyring",
    creates => "/var/lib/ceph/mgr/ceph-${id}/keyring",
    require => [ Ceph::Key['client.admin'] ],
  }

}
