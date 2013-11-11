require 'chefspec'
require 'spec_helper'


describe 'devpi::server' do
  before(:each) do
    @chef_run = ChefSpec::ChefRunner.new
  end

  context 'recipe' do
    subject { @chef_run.converge described_recipe }
    it { should include_recipe 'python' }
    it { should upgrade_python_pip 'devpi server' }
    it { should create_user 'devpi' }
    it { should create_group 'devpi' }
  end

  context 'python environment' do
    subject {
      @chef_run.node.set[:devpiserver][:virtualenv] = '/configured/path'
      @chef_run.converge described_recipe
      @chef_run.python_virtualenv 'devpi environment'
    }
    its(:action) { should include :create }
    its(:path) { should eq '/configured/path' }
  end

  context 'devpi-server installation' do
    subject {
      @chef_run.node.set[:devpiserver][:version] = :configured_version
      @chef_run.converge described_recipe
      @chef_run.python_pip 'devpi server'
    }
    its(:version) { should eq :configured_version }
  end

  context 'devpi privilege separation user' do
    subject {
      @chef_run.node.set[:devpiserver][:daemon_user] = 'configured_user'
      @chef_run.node.set[:devpiserver][:virtualenv] = '/configured/path'
      @chef_run.converge described_recipe
      @chef_run.user 'devpi privilege separation user'
    }
    its(:username) { should eq 'configured_user' }
    its(:group) { should eq 'daemon' }
    its(:shell) { should eq '/bin/false' }
    its(:action) { should include :create }
    its(:home) { should eq '/configured/path' }
  end

  context 'devpi administrative group' do
    subject {
      @chef_run.node.set[:devpiserver][:daemon_user] = 'configured_user'
      @chef_run.node.set[:devpiserver][:admin_group] = 'configured_group'
      @chef_run.converge described_recipe
      @chef_run.group 'devpi administrative group'
    }
    its(:group_name) { should eq 'configured_group' }
    its(:members) { should include 'configured_user' }
  end

end
