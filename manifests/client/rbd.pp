define ceph::client::rbd ($pool=rbd,$id=admin) {
  concat::fragment{"/etc/ceph/rbdmap-${title}":
    target  => '/etc/ceph/rbdmap',
    content => "${pool}/${title}	id=${id},keyring=/etc/ceph/keyring\n",
  }

  exec { "map-rbd-${title}":
    command => "rbd -p ${pool} --id ${id} map ${title}",
    path    => [ '/usr/bin/', '/bin/' ],
    creates => "/dev/rbd/${pool}/${title}",
    require => Package['ceph']
  }

}
