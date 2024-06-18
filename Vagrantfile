domain = "centos7.lab"
master_node_ip = "192.168.57.200"

Vagrant.configure("2") do |config|
    config.ssh.insert_key = false
    config.vm.define "centos7" do |master|
      master.vm.box = "centos/7"
      master.vm.hostname = "#{domain}"
      master.vm.network "private_network", ip: "#{master_node_ip}"
      master.vm.provision "file", source: "testkey.pub", destination: "/home/vagrant/testkey.pub"
      # ADD SSH FOR ROOT USER
      master.vm.provision "shell", inline: <<-SHELL
        mkdir -p ~/.ssh && touch ~/.ssh/authorized_keys
        cat /home/vagrant/testkey.pub >> ~/.ssh/authorized_keys
        chmod 600 ~/.ssh/authorized_keys && chmod 700 ~/.ssh
      SHELL
      master.vm.provision "shell", env: {"DOMAIN" => domain, "MASTER_NODE_IP" => master_node_ip} ,inline: <<-SHELL 
        echo "$MASTER_NODE_IP $DOMAIN centos" >> /etc/hosts 
      SHELL
    end
    config.vm.provider "virtualbox" do |vb|
      vb.memory = "3072"
      vb.cpus = "1"
      vb.customize ["modifyvm", :id, "--nic1", "nat"]
    end
 end


  