#!/bin/bash

REDMINE_HOME="/opt/redmine/redmine-2.5.2"
REDMINE_PLUGINS_DIR="${REDMINE_HOME}/public/themes"

source /etc/environment
source /usr/local/rvm/scripts/rvm

echo "=================================================="
echo "          deploy redmine-themes"
echo "=================================================="

cd ${REDMINE_PLUGINS_DIR}

echo "install gitmike ---->"
git clone git://github.com/makotokw/redmine-theme-gitmike.git gitmike
chown -R www-data:www-data gitmike

echo "install pepper ---->"
git clone https://github.com/koppen/redmine-pepper-theme.git pepper
chown -R www-data:www-data pepper

echo "install pixel-cookers ---->"
wget https://github.com/pixel-cookers/redmine-theme/zipball/master
unzip master
chown -R www-data:www-data pixel-cookers-redmine-theme-21269f2

echo "install axiom ---->"
git clone https://github.com/hulihanapplications/axiom.git
chown -R www-data:www-data axiom

echo "apache2 reload"
service apache2 reload
