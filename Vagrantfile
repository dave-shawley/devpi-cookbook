# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure('2') do |config|

  config.vm.hostname = 'devpi-berkshelf'
  config.vm.box = 'opscode-ubuntu-12.04'
  config.vm.box_url = 'https://opscode-vm-bento.s3.amazonaws.com/vagrant/opscode_ubuntu-12.04_provisionerless.box'

  config.vm.network :private_network, ip: '172.16.0.11'

  config.berkshelf.berksfile_path = './Berksfile'
  config.berkshelf.enabled = true
  config.omnibus.chef_version = '11.6.0'

  config.vm.provision :chef_solo do |chef|
    chef.json = {}
    chef.run_list = [
      'recipe[apt]',
      'recipe[devpi::server]',
    ]
  end

end
