IP=$1

# Copy open files limit configuration
sudo cp /vagrant/conf/tidb-file-limit.conf /etc/security/limits.d/

# Enable max open file
sudo sysctl -w fs.file-max=1000000

# Copy TiDB binary
cp /vagrant/bin/pd-server .
./pd-server --name=pd2 --data-dir=pd --client-urls="http://$IP:2379" --peer-urls="http://$IP:2380" --join="http://192.168.16.104:2379" --log-file=pd.log &

cp /vagrant/bin/node_exporter .
./node_exporter --web.listen-address=":9100" --log.level="info" &