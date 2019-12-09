IP=$1
PD="192.168.16.104:2379,192.168.16.105:2379,192.168.16.106:2379"

# Copy open files limit configuration
sudo cp /vagrant/conf/tidb-file-limit.conf /etc/security/limits.d/

# Enable max open file
sudo sysctl -w fs.file-max=1000000

# Copy TiDB binary
cp /vagrant/bin/pd-server .
./pd-server --name=pd1 --data-dir=pd --client-urls="http://$IP:2379" --peer-urls="http://$IP:2380" --initial-cluster="pd1=http://$IP:2380" --log-file=pd.log &

cp /vagrant/bin/tidb-server .
# ./tidb-server --store=tikv --path="$PD" --log-file=tidb.log &

cp /vagrant/bin/node_exporter .
./node_exporter --web.listen-address=":9100" --log.level="info" &