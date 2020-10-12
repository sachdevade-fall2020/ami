#!/bin/bash

echo "waiting for system setup..."
sleep 20
echo "Done."

echo "------------------------------ start UPDATE PACKAGES ------------------------------ "
sudo apt-get update
echo "------------------------------ end UPDATE PACKAGES ------------------------------  "

echo "------------------------------ start INSTALL PACKAGES ------------------------------  "
sudo apt-get install -y zip unzip
echo "------------------------------ end INSTALL PACKAGES ------------------------------  "

echo "------------------------------ start INSTALL & CONFIGURE APACHE ------------------------------  "
sudo apt-get install -y apache2
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
sudo apt-get install -y software-properties-common
sudo add-apt-repository -y ppa:ondrej/php
sudo apt-get install -y php7.3 libapache2-mod-php7.3
sudo apt-get install -y php7.3-common php7.3-cli php7.3-gd php7.3-mysql php7.3-curl php7.3-intl php7.3-mbstring php7.3-bcmath php7.3-imap php7.3-xml php7.3-zip
echo "------------------------------ end INSTALL & CONFIGURE PHP ------------------------------  "

echo "------------------------------ start INSTALL COMPOSER  ------------------------------  "
php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
php -r "if (hash_file('sha384', 'composer-setup.php') === '795f976fe0ebd8b75f26a6dd68f78fd3453ce79f32ecb33e7fd087d39bfeb978342fb73ac986cd4f54edd0dc902601dc') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;"
sudo php composer-setup.php --install-dir=/usr/local/bin --filename=composer
php -r "unlink('composer-setup.php');"
echo "------------------------------ end INSTALL COMPOSER ------------------------------  "