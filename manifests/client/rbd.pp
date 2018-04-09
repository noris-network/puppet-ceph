define ceph::client::rbd ($pool=rbd,$id=admin) {
  concat::fragment{"/etc/ceph/rbdmap-${title}":
    target  => '/etc/ceph/rbdmap',
    content => "${pool}/${title}	id=${id},keyring=/etc/ceph/keyring\n",
  } ~>

  service{ 'rbdmap':
    ensure => 'running',
    enable => true,
    require => Package['ceph']
  }

}
