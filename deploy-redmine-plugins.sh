#!/bin/bash

REDMINE_HOME="/opt/redmine/redmine-2.5.2"
REDMINE_PLUGINS_DIR="${REDMINE_HOME}/plugins"

source /etc/environment
source /usr/local/rvm/scripts/rvm

function _go_plugin_dir()
{
    cd ${REDMINE_PLUGINS_DIR}
}

function _bundle()
{
    cd ${REDMINE_HOME}
    bundle install --without development test
}

function _rake()
{
    rake redmine:plugins:migrate RAILS_ENV=production
}

function _restart_apache()
{
    service apache2 restart
}

echo "=================================================="
echo "          deploy redmine-plugins"
echo "=================================================="

apt-get install --yes unzip

echo "install Agile ---->"
_go_plugin_dir
wget http://redminecrm.com/license_manager/13082/redmine_agile-1_3_2-light.zip
unzip redmine_agile-1_3_2-light.zip
_bundle
_rake
echo "end"

echo "install CKEditor ---->"
_go_plugin_dir
git clone https://github.com/a-ono/redmine_ckeditor.git
_bundle
_rake
echo "end"

echo "install Progressive Projects List ---->"
_go_plugin_dir
wget https://github.com/stgeneral/redmine-progressive-projects-list/archive/latest.tar.gz
tar xvzf latest.tar.gz
mv redmine-progressive-projects-list-latest/ progressive_projects_list
_bundle
_rake
echo "end"

echo "install screenshot paste ---->"
_go_plugin_dir
git clone https://github.com/undx/redmine_screenshot_paste.git
_bundle
_rake
echo "end"

echo "install CheckLists ---->"
_go_plugin_dir
wget http://redminecrm.com/license_manager/14041/redmine_checklists-3_0_0-light.zip
unzip redmine_checklists-3_0_0-light.zip
_bundle
_rake
echo "end"

echo "install Contacts ---->"
_go_plugin_dir
wget http://redminecrm.com/license_manager/12403/redmine_contacts-3_2_17-light.zip
unzip redmine_contacts-3_2_17-light.zip
_bundle
_rake
echo "end"

echo "install HideSlidebar ---->"
_go_plugin_dir
git clone https://github.com/bdemirkir/sidebar_hide.git
_bundle
_rake
echo "end"

echo "install DMSF ---->"
_go_plugin_dir
git clone https://github.com/danmunn/redmine_dmsf.git
_bundle
_rake
echo "end"

echo "install Knowledgebase ---->"
_go_plugin_dir
git clone git://github.com/alexbevi/redmine_knowledgebase.git redmine_knowledgebase
_bundle
_rake
echo "end"

echo "install Logs ---->"
_go_plugin_dir
wget https://bitbucket.org/haru_iida/redmine_logs/downloads/redmine_logs-0.0.5.zip
unzip redmine_logs-0.0.5.zip
_bundle
_rake
echo "end"

echo "install TimeTracker ---->"
_go_plugin_dir
git clone https://github.com/fernandokosh/redmine_time_tracker.git
_bundle
_rake
echo "end"

echo "install BetterGanttChart ---->"
_go_plugin_dir
git clone https://github.com/kulesa/redmine_better_gantt_chart.git
_bundle
_rake
echo "end"

echo "Restart Apache2"
_restart_apache
