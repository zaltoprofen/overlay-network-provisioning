# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.box = "ubuntu/xenial64"
  config.vm.box_check_update = false
  config.ssh.forward_agent = true
  config.ssh.insert_key = false
  config.ssh.private_key_path = ['ssh/id_ed25519', '~/.vagrant.d/insecure_private_key']

  config.vm.provision :shell, privileged: false do |s|
    pub_key = open('ssh/id_ed25519.pub').readline.strip
    s.inline = <<-SHELL
    echo '#{pub_key}' > $HOME/.ssh/authorized_keys
    SHELL
  end
  config.vm.provision :file, source: 'ssh/config', destination: '$HOME/.ssh/config'
  config.vm.provision :hosts, sync_hosts: true

  config.vm.provision :shell do |s|
    s.inline = <<-SHELL
    apt-get update
    apt-get install -y python
    SHELL
  end

  config.vm.provider :virtualbox do |vb|
    vb.memory = 1024
    vb.cpus = 1
  end

  config.vm.define "node1" do |node|
    node.vm.hostname = "node1"
    node.vm.network "private_network", ip: "92.9.9.2", virtualbox__intnet: "intra"

    node.vm.provision :shell do |s|
      s.inline = <<-SHELL
      apt-add-repository --yes --update ppa:ansible/ansible
      apt-get install -y ansible
      SHELL
    end
  end

  config.vm.define "node2" do |node|
    node.vm.hostname = "node2"
    node.vm.network "private_network", ip: "92.9.9.3", virtualbox__intnet: "intra"
  end
end
