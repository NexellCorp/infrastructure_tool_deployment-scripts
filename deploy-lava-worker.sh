#!/bin/sh

#########################################
# install target : ubuntu-12.04 precise #
#########################################

echo "=================================================="
echo "       deploy lava-worker for development"
echo "=================================================="
sudo apt-get update
sudo apt-get install --yes git

echo "download lava-deployment-tool ---->"
cd $HOME
git clone http://git.nexell.co.kr:8081/nexell/infrastructure/lava-deployment-tool
echo "end"

echo "install lava-deployment-tool ---->"
cd lava-deployment-tool
./lava-deployment-tool setup -nd
LAVA_DB_PASSWORD=rmsiddhk LAVA_MASTER=192.168.1.231 ./lava-deployment-tool installworker lava-worker1
echo "end"

echo "set up development source ---->"
cd $HOME
git clone http://git.nexell.co.kr:8081/nexell/infrastructure/lava-dispatcher
/srv/lava/instances/development/bin/lava-develop-local ~/lava-dispatcher
echo "end"
