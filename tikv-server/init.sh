IP=$1
PD="192.168.16.104:2379,192.168.16.105:2379,192.168.16.106:2379"

# Copy open files limit configuration
sudo cp /vagrant/conf/tidb-file-limit.conf /etc/security/limits.d/

# Enable max open file
sudo sysctl -w fs.file-max=1000000

# Copy TiDB binary
cp /vagrant/bin/tikv-server .
./tikv-server --pd="$PD" --addr="$IP:20160" --data-dir=tikv --log-file=tikv.log &

cp /vagrant/bin/node_exporter .
./node_exporter --web.listen-address=":9100" --log.level="info" &