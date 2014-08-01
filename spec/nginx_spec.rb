require 'chefspec'
require 'spec_helper'

describe 'devpi::nginx' do
  before(:each) do
    @chef_run = ChefSpec::ChefRunner.new
  end

  context 'this recipe' do
    subject do
      @chef_run.converge described_recipe
    end
    it { should include_recipe 'nginx::package' }
    it { should create_file '/etc/nginx/sites-available/devpi-server' }
    it { should create_directory '/var/log/devpi-server' }
    it { should execute_command '/usr/sbin/nxdissite default' }
    it { should execute_command '/usr/sbin/nxensite devpi-server' }
    it { should start_service 'nginx' }
  end

  context 'devpi-server site' do
    subject do
      @chef_run.node.set[:devpiserver][:server_port] = 5678
      @chef_run.converge described_recipe
    end
    it do
      should create_file_with_content(
        '/etc/nginx/sites-available/devpi-server',
        'server 127.0.0.1:5678',
      )
    end
    it do
      should create_file_with_content(
        '/etc/nginx/sites-available/devpi-server',
        'server_name chefspec.local',
      )
    end
  end

  context 'devpi-server site template' do
    subject do
      @chef_run.converge described_recipe
      @chef_run.find_resource(
        'template', '/etc/nginx/sites-available/devpi-server')
    end
    it { should_not be_nil }
    it { should notify 'service[nginx]', :start }
  end

  context 'when nginx dir is /foo' do
    subject do
      @chef_run.node.set[:nginx][:dir] = '/foo'
      @chef_run.converge described_recipe
    end
    it { should create_file '/foo/sites-available/devpi-server' }
  end
end
