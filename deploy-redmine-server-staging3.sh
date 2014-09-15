#!/bin/bash

echo "=================================================="
echo "         deploy redmine-server staging3"
echo "=================================================="

source /etc/environment
source /usr/local/rvm/scripts/rvm

echo "install bundler ---->"
cd /opt/redmine/redmine-2.5.2
#sudo su -
bundle install --without development test
echo "end"

pushd $(pwd)

echo "install apache2 ---->"
apt-get install apache2 apache2-prefork-dev
echo "end"

echo "install passenger ---->"
gem install passenger
cd /usr/local/rvm/gems/ruby-2.0.0-p481/gems/passenger-4.0.50/
./bin/passenger-install-apache2-module
echo "<IfModule mod_passenger.c>" > /etc/apache2/mods-available/passenger.conf
echo "   PassengerUser www-data" >> /etc/apache2/mods-available/passenger.conf
echo "   PassengerDefaultUser www-data" >> /etc/apache2/mods-available/passenger.conf
echo "   PassengerRoot /usr/local/rvm/gems/ruby-2.0.0-p481/gems/passenger-4.0.50" >> /etc/apache2/mods-available/passenger.conf
echo "   PassengerDefaultRuby /usr/local/rvm/wrappers/ruby-2.0.0-p481/ruby" >> /etc/apache2/mods-available/passenger.conf
echo "</IfModule>" >> /etc/apache2/mods-available/passenger.conf
echo "LoadModule passenger_module /usr/local/rvm/gems/ruby-2.0.0-p481/gems/passenger-4.0.50/buildout/apache2/mod_passenger.so" > /etc/apache2/mods-available/passenger.load
a2enmod passenger
echo "end"

echo "setup database ---->"
cd /opt/redmine/redmine-2.5.2
cat <<ENDOFCONF > config/database.yml
production:
    adapter: postgresql
    database: redmine
    host: localhost
    username: redmine
    password: rmsiddhk
    encoding: utf8
    schema_search_path: public
ENDOFCONF
echo "end"

echo "extra work ---->"
rake generate_secret_token
RAILS_ENV=production rake db:migrate
RAILS_ENV=production rake redmine:load_default_data
mkdir public/plugin_assets
chown -R www-data:www-data files log tmp public
chmod -R 755 files log tmp public/plugin_assets
chown -R www-data:www-data ./config/database.yml
chmod 600 ./config/database.yml
echo "end"

echo "setup web ---->"
cd /var/www
ln -s /opt/redmine/redmine-2.5.2/public/ redmine
popd
cp redmine-apache-default /etc/apache2/sites-available/default
a2ensite default
service apache2 restart
echo "end"

ipaddr=$(ifconfig | awk -F':' '/inet addr/{print $2}' | awk -F' ' '{print $1}' | grep -v "127")
"End of deploy remine ====> connect to http://${ipaddr}/redmine"
