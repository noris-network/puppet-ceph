# == Class: ceph::install
#
# This module configures stuff common to all ceph hosts
#
# === Parameters
#
# [*mon_hosts*]
#   This contains a list of all monitor hosts, it is used by all ceph servers
#   and clients to find the mons.
#

class ceph::install {
  apt::source { 'ceph':
    location    => "http://ceph.com/debian-${::ceph::release}/",
    release     => $::ceph::os_release,
    repos       => 'main',
    key         => '17ED316D',
    key_source  => 'https://git.ceph.com/?p=ceph.git;a=blob_plain;f=keys/release.asc',
    include_src => false,
  }
  package { 'ceph':
    ensure => 'installed',
  }
}
