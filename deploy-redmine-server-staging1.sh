#!/bin/bash

#########################################
# install target : ubuntu-12.04 precise #
#########################################

echo "=================================================="
echo "         deploy redmine-server staging1"
echo "=================================================="
sudo apt-get update

echo "install dependency ---->"
sudo apt-get install --yes build-essential libpcre3-dev libruby libssl-dev libcurl4-openssl-dev libpq-dev libreadline-dev libjpeg62-dev libpng12-dev curl openssl libreadline6 libreadline6-dev zlib1g zlib1g-dev libssl-dev libyaml-dev libsqlite3-dev sqlite3 libxml2-dev libxslt1-dev autoconf libc6-dev libncurses5-dev automake libtool bison pkg-config
echo "end"

#echo "change to root ---->"
#sudo su -
#echo "end"

echo "install ruby ---->"
curl -L https://get.rvm.io | sudo bash -s stable
source /etc/profile
rvm install 2.0.0
rvm use 2.0.0
rvm --default use 2.0.0
echo 'PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/usr/local/rvm/bin"' > /etc/environment
echo "end"

echo "install rails ---->"
gem install rdoc
gem install rails -v 3.2.13
echo "end"

echo "install PostgreSQL ---->"
apt-get install postgresql
su - postgres
/usr/bin/psql -f redmine-psql-command.txt
exit
gem install pg
echo "end"

echo "install imagemagick ---->"
apt-get install imagemagick librmagick-ruby libmagickwand-dev
gem install rmagick
echo "end"

echo "get redmine ---->"
mkdir -p /opt/redmine
chown -R $(whoami):$(whoami) /opt/redmine
cd /opt/redmine
wget https://github.com/redmine/redmine/archive/2.5.2.tar.gz
tar xvzf 2.5.2.tar.gz
cd redmine-2.5.2
gem install bundler
echo "end"

echo "deploy staging1 end =====> reboot & run deploy-redmine-server-staging2.sh"
