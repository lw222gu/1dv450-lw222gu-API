# -*- mode: ruby -*-
# vi: set ft=ruby :
Vagrant.configure('2') do |config|
  config.vm.box      = 'ubuntu/precise32'
  config.vm.hostname = 'rails-dev-box'

  config.vm.network :forwarded_port, guest: 4000, host: 4000

  config.vm.provision :shell, path: 'bootstrap.sh', keep_color: true

  config.vm.synced_folder ".", "/vagrant", disabled: true
  config.vm.synced_folder ".", "/home/vagrant"
end
