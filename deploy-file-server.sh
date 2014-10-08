#!/bin/bash

TYPE=${1:-"releases"}

test ${TYPE} == "r" && TYPE="releases" || TYPE="snapshots"

#if [ ${TYPE} == "r" ]
#then
    #TYPE="releases"
#else
    #TYPE="snapshots"
#fi

echo "=================================================="
echo "       deploy file-server for ${TYPE}"
echo "=================================================="

answer=
read -p "is right? [y|N] " answer
case "$answer" in
    [nN] ) exit 0;;
    *    ) echo "go on...";;
esac

DIR=${TYPE}.nexell.co.kr

echo "Install dependencies ---->"
sudo apt-get update
sudo apt-get install --yes libapache2-mod-xsendfile libapache2-mod-python python-django python-django-openid-auth python-apache-openid libapache2-mod-wsgi wsgi-plugin-python python-pip git
sudo pip install south textile BeautifulSoup requests
echo "end"

echo "Setup install directory ---->"
#sudo chown -R $(whoami):$(whoami) /srv
sudo chown $(whoami):$(whoami) /srv
mkdir -p /srv/${DIR}
echo "end"

sudo apt-get install libapache2-mod-xsendfile
sudo apt-get install libapache2-mod-wsgi

echo "Get source and install requirements ---->"
cd /srv/${DIR}
git clone http://git.nexell.co.kr:8081/nexell/infrastructure/linaro-license-protection.git
git clone http://git.nexell.co.kr:8081/nexell/infrastructure/linaro-license-protection-configs.git configs
cd linaro-license-protection
sudo pip install -r requirements.txt
echo "end"

echo "Setup DB ---->"
export PYTHONPATH=/srv/${DIR}:/srv/${DIR}/linaro-license-protection:/srv/${DIR}/configs/django
export DJANGO_SETTINGS_MODULE="settings_snapshots"
mkdir -p /srv/${DIR}/db
django-admin.py syncdb
python /srv/${DIR}/linaro-license-protections/manage.py migrate license_protected_downloads 0001 --fake --settings="settings_snapshots" && touch /srv/${DIR}/db/.south-setup
django-admin.py migrate
django-admin.py collectstatic
sudo chown -R www-data:www-data /srv/${DIR}/linaro-license-protection
sudo chown -R www-data:www-data /srv/${DIR}/configs
echo "end"

echo "Setup apache2 ---->"
sudo cp -a /srv/${DIR}/configs/apache/${TYPE}.conf /etc/apache2/sites-available
sudo a2dissite default
sudo a2ensite ${TYPE}.conf
echo "end"

echo "Create file dir ---->"
mkdir -p /srv/${DIR}/www
echo "end"

echo "Reload apache2 ---->"
sudo service apache2 reload
echo "end"
