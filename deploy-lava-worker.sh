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
SKIP_ROOT_CHECK=yes LAVA_DB_SERVER=192.168.1.231 LAVA_DB_NAME=lav-development LAVA_DB_USER=lava-development LAVA_DB_PASSWORD=rmsiddhk LAVA_REMOTE_FS_HOST=192.168.1.231 LAVA_REMOTE_FS_USER=nexell LAVA_REMOTE_FS_DIR=/srv/lava/instances/development LAVA_SERVER_IP=192.168.1.231 ./lava-deployment-tool installworker -nd lava-worker1
echo "end"

echo "set up development source ---->"
cd $HOME
git clone http://git.nexell.co.kr:8081/nexell/infrastructure/lava-server
git clone http://git.nexell.co.kr:8081/nexell/infrastructure/lava-dispatcher
/srv/lava/instances/lava-worker1/bin/lava-develop-local ~/lava-server
/srv/lava/instances/lava-worker1/bin/lava-develop-local ~/lava-dispatcher
echo "end"
