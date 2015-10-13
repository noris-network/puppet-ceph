# == Class: ceph::install
#

class ceph::install {
  if $::ceph::release {
    apt::source { 'ceph':
      location    => "http://ceph.com/debian-${::ceph::release}/",
      release     => $::ceph::os_release,
      repos       => 'main',
      key         => '17ED316D',
      key_source  => 'https://git.ceph.com/?p=ceph.git;a=blob_plain;f=keys/release.asc',
      include_src => false,
    }
  }
  package { 'ceph':
    ensure => 'installed',
  }
}
