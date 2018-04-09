# == Class: ceph::service
class ceph::service {

  service{ 'rbdmap':
    ensure    => 'running',
    enable    => true,
    tag       => 'rbdmap',
    require   => [ Package['ceph'] ],
    subscribe => [ Concat['/etc/ceph/rbdmap'], Concat['/etc/ceph/ceph.conf'] ]
  }

}
