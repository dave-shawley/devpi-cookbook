require 'chefspec'
require 'spec_helper'


describe 'devpi::server' do
  before(:each) do
    @chef_run = ChefSpec::ChefRunner.new
  end

  context 'recipe' do
    subject { @chef_run.converge described_recipe }
    it { should include_recipe 'python' }
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

end
