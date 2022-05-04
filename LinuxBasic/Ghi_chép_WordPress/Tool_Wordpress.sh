#!/bin/bash
printf "=========================================================================\n"
printf "Chuan bi cai Apache... \n"
printf "=========================================================================\n"

#Cai http:Apache
yum -y install httpd
systemctl start httpd
systemctl enable httpd
firewall-cmd --permanent --zone=public --add-service=http
firewall-cmd --permanent --zone=public --add-service=https
firewall-cmd --reload

clear
printf "=========================================================================\n"
printf "Chuan bi qua trinh tai ban cai dat PHP 5.6... \n"
printf "=========================================================================\n"

yum -y install https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
yum -y install http://rpms.remirepo.net/enterprise/remi-release-7.rpm
yum install yum-utils -y
yum-config-manager --enable remi-php56
yum install php php-mcrypt php-cli php-gd php-curl php-mysql php-ldap php-zip php-fileinfo -y

clear
printf "=========================================================================\n"
printf "Chuan bi qua trinh tai ban cai dat Mariadb... \n"
printf "=========================================================================\n"
#cài mariadb
yum -y install mariadb-server
systemctl start mariadb
systemctl enable mariadb
firewall-cmd --add-service=mysql --permanent
firewall-cmd --reload

clear
printf "=========================================================================\n"
printf "Cai dat mat khau cho tai khoan root mariadb... \n"
printf "=========================================================================\n"
mysql_secure_installation


clear
printf "=========================================================================\n"
printf "Tao CSDL cho WordPress... \n"
printf "=========================================================================\n"

echo "Nhap PASSWORD tai khoan ROOT cua MySQL"
read -s rootpasswd
echo "Nhap ten DATABASE:"
read dbname
echo "Dang tao MySQL database..."
mysql -uroot -p${rootpasswd} -e "CREATE DATABASE ${dbname};"
echo "Tao database thanh cong!"
echo "Danh sach CSDL:"
mysql -uroot -p${rootpasswd} -e "show databases;"
echo ""
echo "Nhap USER cho database: $dbname"
read username
echo "Nhap PASSWORD cho user: $username"
read -s userpass
echo "Dang tao user moi..."
mysql -uroot -p${rootpasswd} -e "CREATE USER ${username}@localhost IDENTIFIED BY '${userpass}';"
echo "Tao user thanh cong!"
echo ""
echo "Granting ALL privileges on ${dbname} to ${username}!"
mysql -uroot -p${rootpasswd} -e "GRANT ALL PRIVILEGES ON ${dbname}.* TO '${username}'@'localhost';"
mysql -uroot -p${rootpasswd} -e "FLUSH PRIVILEGES;"
echo "Buoc tao CSDL hoan thanh!"

#while [ 1 ];do
#clear
#printf "=========================================================================\n"
#printf "Chuan bi qua trinh tai ban cai dat WordPress... \n"
#printf "=========================================================================\n"

#printf "Nhap thong tin CSDL vua tao: \n"
# DB Variables
#echo -n "MySQL Host (localhost): "
#read mysqlhost
#if [ "$mysqlhost" = "" ]; then
#	mysqlhost="localhost"
#fi

#echo -n "Ten CSDL WordPress su dung: "
#read mysqldb

#echo -n "MySQL DB User: "
#read mysqluser

#echo -n "MySQL Password: "
#read mysqlpass

#if [ "$mysqldb" != "" ] && [ "$mysqluser" != "" ] && [ "$mysqlpass" != "" ]; then
#	break
#fi
#done

clear
printf "=========================================================================\n"
printf "Downloading... \n"
printf "=========================================================================\n"

yum install wget -y
cd /var/www/html
wget https://wordpress.org/latest.tar.gz
tar -xzvf latest.tar.gz

mv wordpress/* /var/www/html/

sed -e "s/database_name_here/"$dbname"/" -e "s/username_here/"$username"/" -e "s/password_here/"$userpass"/" wp-config-sample.php > wp-config.php
#sed -e "s/localhost/"$mysqlhost"/" -e "s/database_name_here/"$mysqldb"/" -e "s/username_here/"$mysqluser"/" -e "s/password_here/"$mysqlpass"/" wp-config-sample.php > wp-config.php
systemctl restart httpd

clear
printf "=========================================================================\n"
printf " Xong... \n"
printf "=========================================================================\n"

