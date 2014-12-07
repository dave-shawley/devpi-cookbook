# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure('2') do |config|

  config.vm.hostname = 'devpi-berkshelf'
  config.vm.box = 'ubuntu/trusty64'
  config.vm.network :private_network, ip: '172.16.0.11'

  config.berkshelf.berksfile_path = './Berksfile'
  config.berkshelf.enabled = true
  config.omnibus.chef_version = :latest

  config.vm.provision :chef_solo do |chef|
    chef.json = {}
    chef.run_list = [
      'recipe[apt]',
      'recipe[devpi::server]',
      'recipe[devpi::nginx]',
      'recipe[devpi::client]',
      'recipe[supervisor-daemon::install]'
    ]
  end

end
