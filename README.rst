Deployment helper scripts for nexell infrastructure
***************************************************

Deployment lava-server
======================
.. note::
This script run on target machine
1. install ubuntu-12.04 server
2. get this scripts::
   $ sudo apt-get update
   $ sudo apt-get install git
   $ git clone http://git.nexell.co.kr:8081/nexell/infrastructure/infrastructure-deployment-scripts
3. run deploy-lava-server.sh::
   $ cd infrastructure-deployment-scripts
   $ ./deploy-lava-server.sh

Deployment lava-worker
======================
.. note::
This script run on target machine
1. install ubuntu-12.04 server
2. get this scripts::
   $ sudo apt-get update
   $ sudo apt-get install git
   $ git clone http://git.nexell.co.kr:8081/nexell/infrastructure/infrastructure-deployment-scripts
3. run deploy-lava-worker.sh::
   $ cd infrastructure-deployment-scripts
   $ ./deploy-lava-worker.sh
4. setup sshfs
   get lava worker id_rsa.pub file contents from install log
   -------- WORKER NODE PUBLIC KEY STARTS HERE --------
   copy contents to LAVA SERVER /home/nexell/.ssh/authorized_keys
5. check sshfs mount::
   $ df
6. if not mounted, restart lava worker::
   $ sudo stop lava-instance LAVA_INSTANCE=development
   $ sudo start lava-instance LAVA_INSTANCE=development
7. check sshfs mount

.. note::
if you want to apply changed source, do this::
    $ sudo service stop lava-instance LAVA_INSTANCE=development

.. warning::
if sshfs mount failed, worker lava-scheduler not started, LAVA Server can't see LAVA Worker.
Manually run /srv/lava/instances/development/sbin/mount-masterfs
and, stop/start lava-instance

IP Setting for LAVA
====================

/etc/network/interfaces

LAVA Server
---------------------------------------------------------------------
# This file describes the network interfaces available on your system
# and how to activate them. For more information, see interfaces(5).

# The loopback network interface
auto lo
iface lo inet loopback

# The primary network interface
auto eth0
# iface eth0 inet dhcp
iface eth0 inet static
    address 192.168.1.18
    netmask 255.255.255.0
    gateway 192.168.1.254
    dns-nameservers 168.126.63.1 168.126.63.2 8.8.8.8


LAVA Worker
---------------------------------------------------------------------
# This file describes the network interfaces available on your system
# and how to activate them. For more information, see interfaces(5).

# The loopback network interface
auto lo
iface lo inet loopback

# The primary network interface
auto eth0
#iface eth0 inet dhcp
iface eth0 inet static
address 192.168.1.19
netmask 255.255.255.0
gateway 192.168.1.254 
dns-nameservers 168.126.63.1 168.126.63.2 8.8.8.8

Deployment jenkins
==================
.. note::
This script run on host machine through ssh to target machine
1. install ubuntu-14.04 server
2. get jenkins-tools::
   $ git clone http://git.nexell.co.kr:8081/nexell/infrastructure/jenkins-tools
3. install ansible::
   $ sudo pip install ansible==1.7.1
4. fix jenkins-tools/ansible/hosts-devel-tcwg-ci::
   [vagrant]
   localhost:2222 ===> target machine ip
5. run next command::
   $ ansible-playbook -i hosts-devel-tcwg-ci -l "tcwg-ci:&vagrant" site.yml

Deployment file server
======================
.. note::
This script run on target machine
1. install ubuntu-12.04 server
2. get this script::
   $ sudo apt-get update
   $ sudo apt-get install git
   $ git clone http://git.nexell.co.kr:8081/nexell/infrastructure/infrastructure-deployment-scripts
3. run deploy-file-server.sh with argument releases or snapshots::
   $ ./deploy-file-server.sh releases
   or
   $ ./deploy-file-server.sh snapshots

Deployment redmine server
=========================
.. note::
This script run on target machine
1.  install ubuntu-12.04 server
2.  get this script::
    $ sudo apt-get update
    $ sudo apt-get install git
    $ sudo mkdir -p /srv/
    $ sudo chown -R $(whoami):$(whoami) /srv
    $ cd /srv
    $ git clone http://git.nexell.co.kr:8081/nexell/infrastructure/infrastructure-deployment-scripts
3.  change to root::
    $ sudo su -
4.  run deploy-redmine-server-staging1.sh::
    $ /srv/infrastructure-deployment-scripts/deploy-redmine-server-staging1.sh
5.  do next command::
    $ apt-get install postgresql postgresql-contrib
    $ su - postgres
    $ /usr/bin/psql -f /srv/infrastructure-deployment-scripts/redmine-psql-command.txt
    $ exit
6.  run deploy-redmine-server-staging2.sh::
    $ /srv/infrastructure-deployment-scripts/deploy-redmine-server-staging2.sh
7.  reboot::
    $ reboot
8.  change to root::
    $ sudo su -
9.  run deploy-redmine-server-staging2.sh::
    $ /srv/infrastructure-deployment-scripts/deploy-redmine-server-staging3.sh
10. run deploy-redmine-plugins.sh::
    $ /srv/infrastructure-deployment-scripts/deploy-redmine-plugins.sh
11. run deploy-redmine-themes.sh::
    $ /srv/infrastructure-deployment-scripts/deploy-redmine-themes.sh
