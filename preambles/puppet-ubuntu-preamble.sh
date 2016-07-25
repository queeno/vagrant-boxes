#!/bin/bash

PUPPETREPO='http://apt.puppetlabs.com'
CODENAME='trusty'

# Set the facter/hiera/puppet version
FACTER_VERSION=2.4.1-1puppetlabs1
HIERA_VERSION=1.3.4-1puppetlabs1
PUPPET_VERSION=3.7.4-1puppetlabs1

cat >/etc/apt/sources.list.d/puppetlabs.list <<__END__
deb [arch=amd64] ${PUPPETREPO}/ ${CODENAME} main
__END__

wget -q -O - ${PUPPETREPO}/pubkey.gpg | apt-key add -
apt-get -qq update

apt-get -qq install \
  facter=${FACTER_VERSION} \
  hiera=${HIERA_VERSION}

apt-get -qq install \
  puppet=${PUPPET_VERSION} \
  puppet-common=${PUPPET_VERSION}
