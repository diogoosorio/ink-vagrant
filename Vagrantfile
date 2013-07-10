# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
    config.vm.box = "quantal64"
    config.vm.box_url = "https://github.com/downloads/roderik/VagrantQuantal64Box/quantal64.box"
    config.vm.hostname = "ink-dev"
    config.ssh.forward_agent = true

    config.vm.network :private_network, ip: "192.168.50.8"
    config.vm.synced_folder "shared", "/shared"

    config.vm.provision :shell, :path => "bootstrap.sh"
    config.vm.provision :puppet do |puppet|
        puppet.manifests_path = "manifests"
        puppet.manifest_file  = "default.pp"
        puppet.module_path = "modules"
    end
end
