#!/usr/bin/env bash
sudo su
cd
#mysql
echo "================================================================================"
echo ">>> Installing MySQL 5.7"
echo "================================================================================"
yum -y remove mariadb*
tee -a /etc/yum.repos.d/mysql-community.repo << END
[mysql57-community]
name=MySQL 5.7 Community Server
baseurl=http://repo.mysql.com/yum/mysql-5.7-community/el/7/\$basearch/
enabled=1
gpgcheck=0
END
yum -y -q update
yum -y -q install mysql-community-{server,client,common,libs}-* --exclude='*minimal*'

systemctl start mysqld
systemctl enable mysqld

tempPassword="`grep 'temporary.*root@localhost' /var/log/mysqld.log | sed 's/.*root@localhost: //'`"
newPassword="mySQL@123"

echo -e "[client]\nuser=\"root\"\npassword=\"$tempPassword\"" >> ~/.my.cnf

mysql --connect-expired-password -e  "ALTER USER 'root'@'localhost' IDENTIFIED BY '$newPassword';"
mysql -e "uninstall plugin validate_password;"

sed -i "s/$tempPassword/$newPassword/" ~/.my.cnf

systemctl restart mysqld.service
systemctl enable mysqld.service

mysql -e "FLUSH PRIVILEGES;"

mysql -e "CREATE DATABASE wordpress_db;"
mysql -e "CREATE USER wordpress_user@localhost IDENTIFIED BY 'wordpress';"
mysql -e "GRANT ALL ON wordpress_db.* to wordpress_user@localhost;"
mysql -e "FLUSH PRIVILEGES;"

#apache
echo "================================================================================"
echo ">>> Installing Apache"
echo "================================================================================"
yum -y -q install httpd
systemctl start httpd
systemctl enable httpd

#php
echo "================================================================================"
echo ">>> Installing PHP 7.4"
echo "================================================================================"
yum -y install yum-utils epel-release
yum -y install http://rpms.remirepo.net/enterprise/remi-release-7.rpm
yum -y --enablerepo=remi-php74 install httpd epel-release yum-utils php php-fpm php-gd php-pdo php-mbstring php-pear php-mysql

systemctl stop httpd

# rm -rf /var/www/html
ln -fs /vagrant/public /var/www/html

sed -i "s/error_reporting = .*/error_reporting = E_ALL/" /etc/php.ini
sed -i "s/display_errors = .*/display_errors = On/" /etc/php.ini

systemctl restart httpd


# WordPress
################################################################################
#wget https://wordpress.org/latest.tar.gz
echo "================================================================================"
echo ">>> Installing WordPress"
echo "================================================================================"
rm -rf /var/www/html/*
tar -xzvf /vagrant/latest.tar.gz
mv ~/wordpress/* /var/www/html/ 2>/dev/null
rm -rf wordpress/
cp /var/www/html/wp-config-sample.php /var/www/html/wp-config.php
sed -i 's/database_name_here/wordpress_db/' /var/www/html/wp-config.php
sed -i 's/username_here/wordpress_user/' /var/www/html/wp-config.php
sed -i 's/password_here/wordpress/' /var/www/html/wp-config.php


#phpmyadmin
echo "================================================================================"
echo ">>> Installing PhpMyADMIN 4.5.4.1"
echo "================================================================================"
yum -y -q install wget unzip
wget -q -O ~/phpmyadmin.zip https://github.com/phpmyadmin/phpmyadmin/archive/RELEASE_4_5_4_1.zip
unzip -q ~/phpmyadmin.zip -d /var/www/html
mv /var/www/html/phpmyadmin-RELEASE_4_5_4_1 /var/www/html/phpmyadmin
rm ~/phpmyadmin.zip
