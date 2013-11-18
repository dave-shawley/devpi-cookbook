require 'chefspec'
require 'spec_helper'

describe 'devpi::nginx' do
  before(:each) do
    @chef_run = ChefSpec::ChefRunner.new
  end

  context 'this recipe' do
    subject {
      @chef_run.converge described_recipe
    }
    it { should include_recipe 'nginx::package' }
    it { should create_file '/etc/nginx/sites-available/devpi-server' }
    it { should execute_command '/usr/sbin/nxdissite default' }
    it { should execute_command '/usr/sbin/nxensite devpi-server' }
  end

  context 'devpi-server site' do
    subject {
      @chef_run.node.set[:devpiserver][:server_port] = 5678
      @chef_run.converge described_recipe
    }
    it {
      should create_file_with_content(
        '/etc/nginx/sites-available/devpi-server',
        'server 127.0.0.1:5678',
      )
    }
    it {
      should create_file_with_content(
        '/etc/nginx/sites-available/devpi-server',
        'server_name chefspec.local',
      )
    }
  end

  context 'devpi-server site template' do
    subject {
      @chef_run.converge described_recipe
      @chef_run.find_resource 'template', '/etc/nginx/sites-available/devpi-server'
    }
    it { should_not be_nil }
    it { should notify 'service[nginx]', :start }
  end
end
