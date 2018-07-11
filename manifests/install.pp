# == Class: ceph::install
#

class ceph::install {
  if ($::ceph::release) or ($::ceph::repo_url) or ($::ceph::key_url){

    if $::ceph::repo_url {
      $_repo_url = $::ceph::repo_url
    }
    else {
      $_repo_url = "http://download.ceph.com/debian-${::ceph::release}/"
    }

    if $::ceph::key_url {
      $_key_url = $::ceph::key_url
    }
    else {
      $_key_url = 'http://download.ceph.com/keys/release.asc'
    }

    apt::source { 'ceph':
      location => $_repo_url,
      release  => $::ceph::os_release,
      repos    => 'main',
      key      => {
        'id'     => '08B73419AC32B4E966C1A330E84AC2C0460F3994',
        'source' => $_key_url,
      },
    }

    apt::pin {'ceph':
      priority   => 1001,
      originator => 'ceph.com',
      packages   => '*',
    }
  }

  package { 'ceph':
    ensure => 'installed',
  }

}
