#!/bin/sh

#########################################
# install target : ubuntu-12.04 precise #
#########################################

echo "=================================================="
echo "       deploy lava-server for development"
echo "=================================================="
sudo apt-get update
sudo apt-get install --yes git

echo "download lava-deployment-tool ---->"
cd $HOME
git clone http://git.nexell.co.kr:8081/nexell/infrastructure/lava-deployment-tool
echo "end"

echo "setup/install lava-deployment-tool ---->"
cd lava-deployment-tool
sudo ./lava-deployment-tool setup -nd
sudo ./lava-deployment-tool install -nd development
echo "end"

echo "set up development source ---->"
cd $HOME
git clone http://git.nexell.co.kr:8081/nexell/infrastructure/lava-server
git clone http://git.nexell.co.kr:8081/nexell/infrastructure/lava-dispatcher
/srv/lava/instances/development/bin/lava-develop-local ~/lava-server
/srv/lava/instances/development/bin/lava-develop-local ~/lava-dispatcher
echo "end"

echo "create superuser ---->"
~/lava-deployment-tool/lava-deployment-tool manage development createsuperuser
echo "end"
