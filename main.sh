#!/bin/bash

source downloadFx.sh
source writeFx.sh
source questionFx.sh

############################################
## VARIABLES
############################################

#jetBrains url
jetbrains_url=https://data.services.jetbrains.com/products/download


############################################
## APACHE 2
############################################
print 'yellow' 'Installing apache2'
sudo apt install apache2 -y
sudo a2enmod rewrite

#setting permission to apache user
HTTPDUSER=$(ps axo user,comm | grep -E '[a]pache|[h]ttpd|[_]www|[w]ww-data|[n]ginx' | grep -v root | head -1 | cut -d\  -f1)
sudo setfacl -dR -m u:"$HTTPDUSER":rwX -m u:$(whoami):rwX /var
sudo setfacl -R -m u:"$HTTPDUSER":rwX -m u:$(whoami):rwX /var

############################################
enter
############################################

############################################
## CURL
############################################

print 'yellow' 'Installing curl'
sudo apt install curl -y

############################################
enter
############################################

############################################
## PHP
############################################
print 'yellow' 'Insert php version to install (eg. 7.0): '

read version;

if [ $version != 7.2 ]
then
	sudo apt-get install -y python-software-properties
	sudo add-apt-repository -y ppa:ondrej/php
	sudo apt-get update -y
fi;

sudo apt install 'php'$version 'php'$version'-bcmath' 'php'$version'-curl' 'php'$version'-json' 'php'$version'-mbstring' 'php'$version'-mysql' 'php'$version'-mcrypt' 'php'$version'-xml' 'php'$version'-zip'  'php'$version'-soap' 'php'$version'-gd' -y
sudo apt install libapache2-mod-php$version -y
sudo service apache2 restart

print 'green' 'Installed:'
php -v;

############################################
enter
############################################

############################################
## XDEBUG
############################################
print 'yellow' 'Installing xdebug'
sudo apt install php-xdebug -y

sudo sed -i '/zend_extension=xdebug.so/ i xdebug.remote_host = localhost \
xdebug.remote_enable = 1 \
xdebug.remote_port = 9000 \
xdebug.remote_handler = dbgp \
xdebug.remote_mode = req \
xdebug.remote_autostart = 1' /etc/php/$version/apache2/conf.d/20-xdebug.ini

sudo service apache2 restart

############################################
enter
############################################

############################################
## COMPOSER
############################################
print 'yellow' 'Installing composer'
sudo apt install composer -y

print 'green' 'Installed: '
composer -v;

############################################
enter
############################################

############################################
## PhpUnit
############################################
print 'yellow' 'Would You like to install PhpUnit globally? (y/n)'
result=$(question y n)
if [ "$result" = true ] 
	sudo apt install phpunit -y

############################################
enter
############################################
fi

############################################
## SUBLIME TEXT 3
############################################
print 'yellow' 'Would You like to install sublime-text3? (y/n)'
result=$(question y n)
if [ "$result" = true ]
	then
	wget -qO - https://download.sublimetext.com/sublimehq-pub.gpg | sudo apt-key add -
	sudo apt-get install apt-transport-https
	echo "deb https://download.sublimetext.com/ apt/stable/" | sudo tee /etc/apt/sources.list.d/sublime-text.list
	sudo apt-get update
	sudo apt-get install sublime-text

############################################
enter
############################################
fi


############################################
## PHPSTORM
############################################
print 'yellow' 'Would You like to install  PhpStorm? (y/n)'
result=$(question y n)
if [ "$result" = true ] 
	then
	url=$(curl -w "%{url_effective}\n" -I -L -s -S $jetbrains_url?code=PS\&platform=linux -o /dev/null)
	download $url 'phpstorm.tar.bz' 'phpstorm'

############################################
enter
############################################
fi


############################################
## DATAGRIP
############################################
print 'yellow' 'Would You like to install  Datagrip? (y/n)'
result=$(question y n)
if [ "$result" = true ] 
	then
	url=$(curl -w "%{url_effective}\n" -I -L -s -S $jetbrains_url?code=DG\&platform=linux -o /dev/null)
	download $url 'datagrip.tar.bz' 'datagrip' 

############################################
enter
############################################
fi


############################################
## FIREFOX DEVELOPER EDITION
############################################
print 'yellow' 'Would You like to install Firefox developer edition? (y/n)'
result=$(question y n)
if [ "$result" = true ] 
	then
	url=https://download.mozilla.org/?product=firefox-devedition-latest-ssl&amp;os=linux64&amp;lang=pl
	download $url 'ffdeveloper.tar.bz' 'firefox'

############################################
enter
############################################
fi


############################################
## POSTMAN
############################################
print 'yellow' 'Would You like to install Postman? (y/n)'
result=$(question y n)
if [ "$result" = true ] 
	then
	sudo apt install libgconf2-4
	url=https://dl.pstmn.io/download/latest/linux64
	download $url 'postman.tar.bz' 'postman'

############################################
enter
############################################
fi


############################################
## MYSQL
############################################
print 'yellow' 'Would You like to install mysql oraz phpmyadmin? (y/n)'
result=$(question y n)
if [ "$result" = true ] 
	then
	sudo apt install mysql-server -y
	sudo apt install phpmyadmin -y
	sudo ln -s /etc/phpmyadmin/apache.conf /etc/apache2/conf-available/phpmyadmin.conf
	sudo a2enconf phpmyadmin.conf
	sudo systemctl reload apache2.service

############################################
enter
############################################
fi


############################################
## MYSQL WORKBANCH
############################################
print 'yellow' 'Would You like to install Mysql-Workbanch? (y/n)'
result=$(question y n)
if [ "$result" = true ] 
	then
	sudo apt-get update
	sudo apt-get install mysql-workbench -y

############################################
enter
############################################
fi


############################################
## OpenVPN
############################################
print 'yellow' 'Would You like to install  OpenVPN? (y/n)'
result=$(question y n)
if [ "$result" = true ] 
	then
	sudo apt install openvpn easy-rsa -y

############################################
enter
############################################
fi


############################################
## Filezilla
############################################
print 'yellow' 'Would You like to install Filezilla? (y/n)'
result=$(question y n)
if [ "$result" = true ] 
	then
	sudo apt install filezilla -y

############################################
enter
############################################
fi



############################################
## Git
############################################
print 'yellow' 'Do You want to install and configure git? (y/n)'
result=$(question y n)
if [ "$result" = true ] 
	then
	sudo apt install git -y

	print 'blue' 'Insert user.name'
	read username
	print 'blue' 'Insert user.email'
	read useremail

	git config --global user.name $username
	git config --global user.email $useremail

############################################
enter
############################################
fi


print 'yellow' 'Do You want to set default text editor for git? (y/n)'
result=$(question y n)
if [ "$result" = true ] 
	then
	print 'blue' 'Insert default editor, eg. vim, subl (for sublime-text3), gedit'
	read editor
	git config --global core.editor editor

############################################
enter
############################################
fi


############################################
## NodeJs
############################################
print 'yellow' 'Do You want to install NodeJs? (y/n)'
result=$(question y n)
if [ "$result" = true ] 
	then
	sudo apt install -y nodejs

############################################
enter
############################################
fi

############################################
## Autoclean
############################################
print 'yellow' 'Do You want excecute autoclean, autoremove? (y/n)'
result=$(question y n)
if [ "$result" = true ] 
	then
	sudo apt-get update
	sudo apt-get upgrade -y
	sudo apt-get autoclean -y
	sudo apt-get autoremove -y
fi


print 'green' 'Done :)'

############################################
enter
############################################


