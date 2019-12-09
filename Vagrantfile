# -*- mode: ruby -*-
# vi: set ft=ruby :

VAGRANTFILE_API_VERSION = "2"

cluster = {
  "node1" => { :ip => "192.168.16.104", :box => "centos/7", :cpus => 1, :mem => 512, :provision => "node1/init.sh" },
  "node2" => { :ip => "192.168.16.105", :box => "centos/7", :cpus => 1, :mem => 512, :provision => "node2/init.sh" },
  "node3" => { :ip => "192.168.16.106", :box => "centos/7", :cpus => 1, :mem => 512, :provision => "node3/init.sh" },
  "node4" => { :ip => "192.168.16.107", :box => "centos/7", :cpus => 1, :mem => 512, :provision => "tikv-server/init.sh" },
  "node5" => { :ip => "192.168.16.108", :box => "centos/7", :cpus => 1, :mem => 512, :provision => "tikv-server/init.sh" },
  "node6" => { :ip => "192.168.16.109", :box => "centos/7", :cpus => 1, :mem => 512, :provision => "tikv-server/init.sh" },
  "node7" => { :ip => "192.168.16.110", :box => "ubuntu/bionic64", :cpus => 1, :mem => 512, :provision => "wordpress/init.sh" },
}

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

  cluster.each_with_index do |(hostname, info), index|

    config.vm.define hostname do |node|
      node.vm.hostname = hostname
      node.vm.box = info[:box]
      node.vm.network :private_network, ip: "#{info[:ip]}"

      config.vm.box_check_update = false

      node.vm.provider :virtualbox do |vb|
        vb.name = hostname
        vb.gui = false
        vb.memory = info[:mem]
        vb.cpus = info[:cpus]
      end

      node.vm.provision "shell", run: "once", path: info[:provision], args: [info[:ip]]

      node.trigger.after :up do |trigger|
          trigger.only_on = "node6"
          trigger.info = "Running only after node6 is up!"
          trigger.run = {inline: "vagrant ssh node1 -- './tidb-server --store=tikv --path=\"192.168.16.104:2379,192.168.16.105:2379,192.168.16.106:2379\" --log-file=tidb.log &'"}
      end

    end

  end

end
