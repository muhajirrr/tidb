IP=$1

sudo apt-get update

# Install mysql client
sudo apt-get install -y mysql-client

sudo apt-get install -y apache2
sudo apt-get install -y php libapache2-mod-php php-mysql
sudo cp /vagrant/wordpress/000-default.conf /etc/apache2/sites-available/000-default.conf
sudo service apache2 restart

wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar

sudo chmod +x wp-cli.phar
sudo mv wp-cli.phar /usr/local/bin/wp

mysql -h 192.168.16.104 -P 4000 -u root -e "CREATE DATABASE wordpress"

sudo -u vagrant mkdir wp
sudo -u vagrant wp core download --path=wp
sudo -u vagrant wp core config --dbname='wordpress' --dbuser='root' --dbhost='192.168.16.104:4000' --dbprefix='wp_' --path=wp
sudo -u vagrant wp core install --url="$IP" --title='Wordpress' --admin_user='admin' --admin_password='admin' --admin_email='admin@admin.com' --path=wp