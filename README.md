# puppet-ceph

[![Build Status](https://api.travis-ci.org/noris-network/puppet-ceph.png)](https://travis-ci.org/noris-network/puppet-ceph)

#### Table of Contents

1. [Overview](#overview)
3. [Setup - The basics of getting started with puppet-ceph](#setup)
    * [What puppet-ceph affects](#what-puppet-ceph-affects)
    * [Setup requirements](#setup-requirements)
    * [Beginning with puppet-ceph](#beginning-with-puppet-ceph)
4. [Parameters](#parameters)

## Overview

This module configures a ceph cluster.

## Setup

### What puppet-ceph affects

The module will setup the ceph Package repository, and installs the ceph packages.
It will configure /etc/ceph.conf.
On osd servers it will mount and setup the data partitions.

### Setup Requirements


### Beginning with puppet-ceph

```puppet

node 'mon01.example.com' {
  class {'ceph':
    mon_hosts   => [ 'mon01.example.com', 'mon02.example.com', 'mon03.example.com' ]
    release     => 'hammer',
    cluster_net => '1.2.3.0/24',
    public_net  => '1.2.4.0/24',
  }

  class {'ceph::server::mon':
    id => 1
  }
}

node 'osd01.example.com' {
  class {'ceph':
    mon_hosts   => [ 'mon01.example.com', 'mon02.example.com', 'mon03.example.com' ]
    release     => 'hammer',
    cluster_net => '1.2.3.0/24',
    public_net  => '1.2.4.0/24',
  }

  ceph::server::osd { 0:
    data    => '/dev/sdc',
    journal => '/dev/sdb1',
  }

  ceph::server::osd { 1:
    data    => '/dev/sdd',
    journal => '/dev/sdb2',
  }
}

```

