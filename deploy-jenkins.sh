#!/bin/bash

echo "Install jenkins"
wget -q -O - https://jenkins-ci.org/debian/jenkins-ci.org.key | sudo apt-key add -
sudo sh -c 'echo deb http://pkg.jenkins-ci.org/debian binary/ > /etc/apt/sources.list.d/jenkins.list'
sudo apt-get update
sudo apt-get install --yes jenkins
sudo apt-get install --yes libcurl4-openssl-dev
sudo apt-get install --yes python-pip
sudo apt-get install --yes python-pycurl

echo "Install plugins"
sudo su jenkins
cd
cd plugins
echo "===> scripttrigger"
curl -O https://updates.jenkins-ci.org/latest/scripttrigger.hpi
curl http://localhost/reload
exit

echo "Install End"
