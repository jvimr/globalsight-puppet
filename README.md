globalsight-puppet
==================

globalsight.com installation puppet script  for ubuntu 12.04

installation steps:

apt-get update
apt-get install puppet vim git

mkdir src
cd src
git clone git://github.com/jvimr/globalsight-puppet.git

puppet module install puppetlabs-mysql

cd globalsight-puppet

cd manifests/

puppet apply gs.pp
