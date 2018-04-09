# ceph::client::rbd
define ceph::client::rbd ($pool=rbd,$id=admin) {
  concat::fragment{"/etc/ceph/rbdmap-${title}":
    target  => '/etc/ceph/rbdmap',
    content => "${pool}/${title}	id=${id},keyring=/etc/ceph/keyring\n",
  } ~> Service<| tag == 'rbdmap' |>


}
