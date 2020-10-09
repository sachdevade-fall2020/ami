#!/bin/bash

echo "------------------------------ start UPDATE PACKAGES ------------------------------ "
sudo apt update
sudo apt upgrade -y
sudo unattended-upgrade
echo "------------------------------ end UPDATE PACKAGES ------------------------------  "

echo "------------------------------ start INSTALL PACKAGES ------------------------------  "
sudo apt install -y zip unzip
echo "------------------------------ end INSTALL PACKAGES ------------------------------  "

echo "------------------------------ start INSTALL & CONFIGURE APACHE ------------------------------  "
sudo apt install -y apache2
sudo systemctl start apache2
sudo a2enmod rewrite
cat << 'EOF' | sudo tee /etc/apache2/sites-available/000-default.conf
<VirtualHost *:80>
    ServerAdmin webmaster@localhost
    DocumentRoot /var/www/html/public

    <Directory "/var/www/html/public">
        Options FollowSymLinks
        AllowOverride All
        ReWriteEngine On
    </Directory>

    ErrorLog ${APACHE_LOG_DIR}/error.log
    CustomLog ${APACHE_LOG_DIR}/access.log combined
</VirtualHost>
EOF
sudo systemctl restart apache2
echo "------------------------------ end INSTALL & CONFIGURE APACHE ------------------------------  "

echo "------------------------------ start INSTALL & CONFIGURE PHP ------------------------------  "
sudo apt install -y php libapache2-mod-php php-mysql
sudo apt install -y php7.2-common php7.2-cli php7.2-gd php7.2-mysql php7.2-curl php7.2-intl php7.2-mbstring php7.2-bcmath php7.2-imap php7.2-xml php7.2-zip
echo "------------------------------ end INSTALL & CONFIGURE PHP ------------------------------  "

echo "------------------------------ start INSTALL COMPOSER  ------------------------------  "
php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
php -r "if (hash_file('sha384', 'composer-setup.php') === '795f976fe0ebd8b75f26a6dd68f78fd3453ce79f32ecb33e7fd087d39bfeb978342fb73ac986cd4f54edd0dc902601dc') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;"
sudo php composer-setup.php --install-dir=/usr/local/bin --filename=composer
php -r "unlink('composer-setup.php');"
echo "------------------------------ end INSTALL COMPOSER ------------------------------  "