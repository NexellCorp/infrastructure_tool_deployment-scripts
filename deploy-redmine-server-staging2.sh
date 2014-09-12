#!/bin/bash

echo "install pg ---->"
gem install pg
echo "end"

echo "install imagemagick ---->"
apt-get install imagemagick librmagick-ruby libmagickwand-dev
gem install rmagick
echo "end"

echo "get redmine ---->"
mkdir -p /opt/redmine
cd /opt/redmine
wget https://github.com/redmine/redmine/archive/2.5.2.tar.gz
tar xvzf 2.5.2.tar.gz
cd redmine-2.5.2
gem install bundler
echo "end"

echo "deploy staging2 end =====> reboot & run deploy-redmine-server-staging3.sh"
