require 'chefspec'
require 'spec_helper'


describe 'devpi::supervisor' do
  before(:each) do
    @chef_run = ChefSpec::ChefRunner.new
  end

  context 'recipe' do
    subject { @chef_run.converge described_recipe }
    it { should include_recipe 'supervisor' }
    it { should include_recipe 'devpi::server' }
  end

  context 'supervisor service' do
    subject {
      @chef_run.node.set[:devpiserver][:daemon_user] = 'configured_user'
      @chef_run.node.set[:devpiserver][:virtualenv] = '/configured/path'
      @chef_run.node.set[:devpiserver][:server_root] = '/configured/server/root'
      @chef_run.node.set[:devpiserver][:server_port] = 65432
      @chef_run.converge described_recipe
      @chef_run.find_resource 'supervisor_service', 'devpi-server'
    }
    its(:action) { should eq [:enable] }
    its(:command) { should match %r{^/configured/path/bin/devpi-server .*} }
    its(:command) { should match %r{^.* --serverdir /configured/server/root.*} }
    its(:command) { should match %r{^.* --port 65432 ?.*} }
    its(:user) { should eq 'configured_user' }
  end

end
