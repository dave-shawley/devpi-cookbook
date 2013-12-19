require 'spec_helper'

describe 'devpi::client' do
  before(:each) do
    @chef_run = ChefSpec::Runner.new
    stub_command("/usr/bin/python -c 'import setuptools'").and_return true
  end

  context 'recipe' do
    subject { @chef_run.converge described_recipe }
    it { should include_recipe 'python' }
    it { should upgrade_python_pip 'devpi-client' }
    it { should create_python_virtualenv 'devpi environment' }
  end

  context 'python environment' do
    subject {
      @chef_run.node.set[:devpiserver][:virtualenv] = '/configured/path'
      @chef_run.converge described_recipe
      @chef_run.find_resource 'python_virtualenv', 'devpi environment'
    }
    it { should_not be_nil }
    its(:action) { should include :create }
    its(:path) { should eq '/configured/path' }
  end

  context 'devpi-client installation' do
    subject {
      @chef_run.node.set[:devpiserver][:version] = :configured_version
      @chef_run.node.set[:devpiserver][:virtualenv] = '/configured/path'
      @chef_run.converge described_recipe
      @chef_run.find_resource 'python_pip', 'devpi-client'
    }
    its(:version) { should eq :configured_version }
    its(:virtualenv) { should eq '/configured/path' }
  end
end
