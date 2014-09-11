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
1. install ubuntu-12.04 server
2. get this script::
   $ sudo apt-get update
   $ sudo apt-get install git
   $ git clone http://git.nexell.co.kr:8081/nexell/infrastructure/infrastructure-deployment-scripts
3. run deploy-redmine-server-staging1.sh
4. reboot
5. run deploy-redmine-server-staging2.sh
6. run deploy-redmine-plugins.sh
