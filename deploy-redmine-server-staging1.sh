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

