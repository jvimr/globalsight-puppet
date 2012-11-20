globalsight-puppet
==================

globalsight.com installation puppet script  for ubuntu 12.04

based on following howto: http://www.globalsight.com/wiki/index.php/Installing_GlobalSight_on_Ubuntu

and following thread: http://www.globalsight.com/index.php?option=com_fireboard&Itemid=101&func=view&id=2279&view=flat&catid=26



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
