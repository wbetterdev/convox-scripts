#!/bin/bash


# exit when any command fails
set -e

# keep track of the last executed command
trap 'last_command=$current_command; current_command=$BASH_COMMAND' DEBUG
# echo an error message before exiting
trap 'echo "\"${last_command}\" command failed with exit code $?."' EXIT


if ! [ -x "$(command -v apache2)" ]; then
	echo "Installing apache2"
	echo "Sleeping for 10 seconds. Click ctrl+C to abort script."
	sleep 10s

	sudo apt install -y apache2
	sudo a2enmod ssl
	sudo a2enmod proxy
	sudo a2enmod proxy_http
	sudo a2enmod headers
	sudo a2enmod rewrite
	sudo a2enmod expires
else
  echo 'apache2 is already installed. Skipping.'
fi

if ! test -f "/etc/ssl/certs/apache-office-selfsigned.crt"; then
	echo "Copying certificates to apache"
	echo "Sleeping for 10 seconds. Click ctrl+C to abort script."
	sleep 10s

	sudo cp -v ~/Work/docs/certs/apache/office-selfsigned/office-selfsigned.crt /etc/ssl/certs/apache-office-selfsigned.crt
	sudo cp -v ~/Work/docs/certs/apache/office-selfsigned/office-selfsigned.key /etc/ssl/private/apache-office-selfsigned.key
	sudo cp -v ~/Work/docs/certs/apache/waybetterdev-selfsigned/waybetterdev-selfsigned.crt /etc/ssl/certs/apache-waybetterdev-selfsigned.crt
	sudo cp -v ~/Work/docs/certs/apache/waybetterdev-selfsigned/waybetterdev-selfsigned.key /etc/ssl/private/apache-waybetterdev-selfsigned.key
	sudo cp -v ~/Work/docs/certs/apache/waybetter-selfsigned/waybetter-selfsigned.crt /etc/ssl/certs/apache-waybetter-selfsigned.crt
	sudo cp -v ~/Work/docs/certs/apache/waybetter-selfsigned/waybetter-selfsigned.key /etc/ssl/private/apache-waybetter-selfsigned.key
	sudo cp -v ~/Work/docs/certs/apache/ninja-selfsigned/ninja-selfsigned.crt /etc/ssl/certs/apache-ninja-selfsigned.crt
	sudo cp -v ~/Work/docs/certs/apache/ninja-selfsigned/ninja-selfsigned.key /etc/ssl/private/apache-ninja-selfsigned.key
	sudo cp -v ~/Work/docs/certs/apache/local-selfsigned/local-selfsigned.crt /etc/ssl/certs/apache-local-selfsigned.crt
	sudo cp -v ~/Work/docs/certs/apache/local-selfsigned/local-selfsigned.key /etc/ssl/private/apache-local-selfsigned.key
else
  echo 'Apache certificates already installed. Skipping.'
fi

if ! test -f "/usr/share/ca-certificates/waybetterdev-selfsigned-rootCA.crt"; then
	echo "Installing root certificates"
	echo "Sleeping for 10 seconds. Click ctrl+C to abort script."
	sleep 10s


	sudo cp -v ~/Work/docs/certs/apache/waybetterdev-selfsigned/waybetterdev-selfsigned-rootCA.crt /usr/share/ca-certificates/waybetterdev-selfsigned-rootCA.crt
	sudo cp -v ~/Work/docs/certs/apache/waybetter-selfsigned/waybetter-selfsigned-rootCA.crt /usr/share/ca-certificates/waybetter-selfsigned-rootCA.crt
	sudo cp -v ~/Work/docs/certs/apache/ninja-selfsigned/ninja-selfsigned-rootCA.crt /usr/share/ca-certificates/ninja-selfsigned-rootCA.crt
	sudo cp -v ~/Work/docs/certs/apache/office-selfsigned/office-selfsigned-rootCA.crt /usr/share/ca-certificates/office-selfsigned-rootCA.crt
	sudo cp -v ~/Work/docs/certs/apache/local-selfsigned/local-selfsigned-rootCA.crt /usr/share/ca-certificates/local-selfsigned-rootCA.crt
	sudo bash -c 'echo "waybetterdev-selfsigned-rootCA.crt" >> /etc/ca-certificates.conf'
	sudo bash -c 'echo "waybetter-selfsigned-rootCA.crt" >> /etc/ca-certificates.conf'
	sudo bash -c 'echo "ninja-selfsigned-rootCA.crt" >> /etc/ca-certificates.conf'
	sudo bash -c 'echo "office-selfsigned-rootCA.crt" >> /etc/ca-certificates.conf'
	sudo bash -c 'echo "local-selfsigned-rootCA.crt" >> /etc/ca-certificates.conf'
	sudo update-ca-certificates
else
  echo 'Root certificates already installed. Skipping.'
fi

if ! [ -x "$(command -v php)" ]; then
	echo "Installing php 7.4 and mysqli"
	echo "Sleeping for 10 seconds. Click ctrl+C to abort script."
	sleep 10s


	sudo apt-get install -y libapache2-mod-php7.4
	sudo apt-get install -y php7.4-mbstring php7.4-curl
	sudo a2enmod php7.4
	sudo apt-get install -y php7.4-mysqli
	sudo apt-get install -y php7.4-pgsql
	sudo apt-get install php7.4-dom
	sudo apt-get install php7.4-gd
else
  echo 'php is already installed. Skipping.'
fi


if ! test -d "/var/www/wb-proxy"; then
	echo "Installing https-proxy and phpmyadmin"
	echo "Sleeping for 10 seconds. Click ctrl+C to abort script."
	sleep 10s

	echo "Creating /var/www path"
	sudo mkdir /var/www/wb-proxy
	sudo mkdir /var/www/wb-proxy/logs

	# TODO: 777 is a a bad solution. Need to fix apache user
	echo "Fixing permissions"
	sudo chmod 777 -R /var/www
else
  echo 'phpmyadmin is already installed. Skipping.'
fi


if ! test -d "/var/www/phpmyadmin"; then
	echo "Installing https-proxy and phpmyadmin"
	echo "Sleeping for 10 seconds. Click ctrl+C to abort script."
	sleep 10s

	echo "Installing phpmyadmin"
	wget -O ~/Work/phpmyadmin.zip https://files.phpmyadmin.net/phpMyAdmin/5.0.2/phpMyAdmin-5.0.2-all-languages.zip
	unzip ~/Work/phpmyadmin.zip -d ~/Work/
	rm ~/Work/phpmyadmin.zip
	sudo cp -vr ~/Work/phpMyAdmin-5.0.2-all-languages /var/www/phpmyadmin

	echo "Fixing permissions"
	sudo chmod 777 -R /var/www/phpmyadmin
else
  echo 'phpmyadmin is already installed. Skipping.'
fi

if ! test -f "/etc/apache2/sites-enabled/wb-proxy-ssl.conf"; then
	echo "Installing apache conf files"
	echo "Sleeping for 10 seconds. Click ctrl+C to abort script."
	sleep 10s

	echo "Generating apache conf."
	~/Work/docs/scripts/installs/apache-conf/build-apache-conf-and-install.sh
else
  echo 'Apache conf file is already installed. Skipping.'
fi


echo "Restarting apache"
sudo systemctl restart apache2.service
