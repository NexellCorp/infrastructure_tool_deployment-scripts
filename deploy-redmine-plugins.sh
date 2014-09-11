#!/bin/bash

echo "=================================================="
echo "          deploy redmine-plugins"
echo "=================================================="

sudo su -

echo "install Agile ---->"
cd /opt/redmine/redmine-2.5.2/plugins
wget http://redminecrm.com/license_manager/13082/redmine_agile-1_3_2-light.zip
unzip redmine_agile-1_3_2-light.zip
bundle install --without development test
rake redmine:plugins:migrate RAILS_ENV=production
service apache2 restart
echo "end"

echo "install CKEditor ---->"
cd /opt/redmine/redmine-2.5.2/plugins
git clone https://github.com/a-ono/redmine_ckeditor.git
cd ..
bundle install --without development test 
rake redmine:plugins:migrate RAILS_ENV=production
service apache2 restart
echo "end"
