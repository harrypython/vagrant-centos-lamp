# -*- mode: ruby -*-
# vi: set ft=ruby :

unless Vagrant.has_plugin?("vagrant-hostsupdater")
  system("vagrant plugin install vagrant-hostsupdater")
  puts "Dependencies installed, please try the command again."
  exit
end

Vagrant.configure("2") do |config|

  config.vm.box = "bento/centos-7.4"
  config.vm.provider :virtualbox do |vb|
	vb.name = "vagrant-centos-lamp"
  end

  config.vm.synced_folder "public_html", "/var/www/html/"
  config.vm.allow_hosts_modification = true
  config.vm.network "private_network", ip: "192.168.48.13"
  config.vm.hostname = "mylamp.dev"
  config.hostsupdater.aliases = ["mylamp.dev"]

  config.vm.provision "shell", path: "shell_provisioner/bootstrap.sh"

end
