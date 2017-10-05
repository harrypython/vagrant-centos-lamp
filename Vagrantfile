# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|

  config.vm.box = "bento/centos-7.4"
  config.vm.provider :virtualbox do |vb|
	vb.name = "vagrant-centos-lamp"
  end
  
  config.vm.synced_folder "./www", "/var/www"
  
  config.vm.provision "shell", path: "shell_provisioner/vagrant.bootstrap.sh"
  config.vm.provision "shell", inline: "systemctl restart httpd.service", run: "always"

end
