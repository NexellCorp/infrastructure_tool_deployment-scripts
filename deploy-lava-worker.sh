#!/bin/sh

#########################################
# install target : ubuntu-12.04 precise #
#########################################

NEXELL_LAVA_SERVER=192.168.1.18
INSTANCE_NAME=development

echo "=================================================="
echo "       deploy lava-worker for development"
echo "=================================================="
sudo apt-get update
sudo apt-get install --yes git
sudo apt-get install --yes android-tools-adb android-tools-fastboot
sudo apt-get install --yes cu

echo "download lava-deployment-tool ---->"
cd $HOME
git clone http://git.nexell.co.kr:8081/nexell/infrastructure/lava-deployment-tool
echo "end"

echo "install lava-deployment-tool ---->"
cd lava-deployment-tool
./lava-deployment-tool setup -nd
SKIP_ROOT_CHECK=yes LAVA_DB_SERVER=${NEXELL_LAVA_SERVER} LAVA_DB_NAME=lav-${INSTANCE_NAME} LAVA_DB_USER=lava-${INSTANCE_NAME} LAVA_DB_PASSWORD=rmsiddhk LAVA_REMOTE_FS_HOST=${NEXELL_LAVA_SERVER} LAVA_REMOTE_FS_USER=nexell LAVA_REMOTE_FS_DIR=/srv/lava/instances/${INSTANCE_NAME} LAVA_MASTER=${NEXELL_LAVA_SERVER} ./lava-deployment-tool installworker -nd ${INSTANCE_NAME}
echo "end"

echo "set up development source ---->"
cd $HOME
git clone http://git.nexell.co.kr:8081/nexell/infrastructure/lava-server
git clone http://git.nexell.co.kr:8081/nexell/infrastructure/lava-dispatcher
/srv/lava/instances/${INSTANCE_NAME}/bin/lava-develop-local ~/lava-server
/srv/lava/instances/${INSTANCE_NAME}/bin/lava-develop-local ~/lava-dispatcher

sudo adduser nexell fuse

mkdir -p /srv/lava/instances/development/etc/lava-dispatcher/devices /srv/lava/instances/development/etc/lava-dispatcher/device-types
cp ~/lava-dispatcher/lava_dispatcher/default-config/lava-dispatcher/device-types/pyrope.conf device-types
cp ~/lava-dispatcher/lava_dispatcher/nexell_test/devices/drone-nxp5430.conf devices

sudo start lava-instance LAVA_INSTANCE=${INSTANCE_NAME}

echo "end"
