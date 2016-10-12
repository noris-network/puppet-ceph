# == Class: ceph::install
#

class ceph::install {
  if ($::ceph::release) or ($::ceph::repo_url) {

    if $::ceph::repo_url {
      $_repo_url = $::ceph::repo_url
    }
    else {
      $_repo_url = "http://download.ceph.com/debian-${::ceph::release}/"
    }

    apt::source { 'ceph':
      location    => $_repo_url,
      release     => $::ceph::os_release,
      repos       => 'main',
      key         => '08B73419AC32B4E966C1A330E84AC2C0460F3994',
      key_source  => 'https://git.ceph.com/?p=ceph.git;a=blob_plain;f=keys/release.asc',
      include_src => false,
    }

    apt::pin {'ceph':
      priority   => 1001,
      originator => 'RedHat',
      packages   => '*',
    }
  }

  package { 'ceph':
    ensure => 'installed',
  }
}
