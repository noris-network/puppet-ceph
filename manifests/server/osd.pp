# == Class: ceph::osd
#
# This module configures a single osd for ceph
#
# === Parameters
#
# [*data*]
#   This is the device where data is stored on, e.g. /dev/sdb
#
# [*journal']
#   This is the device where the journal files are stored (small)
#
# [*location*]
#   The location of this osd.

define ceph::server::osd ($data,$journal=undef,$location=undef){

  concat::fragment { "/etc/ceph/ceph.conf-osd-${title}":
    target  => '/etc/ceph/ceph.conf',
    content => template("${module_name}/ceph.conf-osd.erb"),
    order   => 2,
  }

  file { "/var/lib/ceph/osd/ceph-${title}" :
    ensure => directory,
    mode   => '0750',
    owner  => 'ceph',
    group  => 'ceph',
  }

  mount { "/var/lib/ceph/osd/ceph-${title}":
    ensure  => 'mounted',
    device  => $data,
    fstype  => 'xfs',
    options => 'inode64',
    atboot  => true,
    require => File["/var/lib/ceph/osd/ceph-${title}"],
    pass    => 2,
  }
  if $journal {
    file { "/etc/udev/rules.d/90-ceph-osd-${title}.rules":
      ensure  => file,
      content => "KERNEL==\"${journal}\", SUBSYSTEM==\"block\", OWNER=\"ceph\"",
    }
    $journal_string="--osd-journal ${journal}"
  }
  exec { "createosd-${title}":
    user    => 'ceph',
    require => [
      Mount["/var/lib/ceph/osd/ceph-${title}"],
      File['/etc/ceph/ceph.conf'],
      Package['ceph'],
      Ceph::Key['client.admin'],
    ],
    command => "/usr/bin/ceph-osd -i ${title} --mkfs --mkkey ${journal_string} && /usr/bin/ceph auth add osd.${title} osd 'allow *' mon 'allow rwx' -i /var/lib/ceph/osd/ceph-${title}/keyring",
    creates => "/var/lib/ceph/osd/ceph-${title}/keyring",
  }
}
