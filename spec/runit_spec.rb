require 'chefspec'
require 'spec_helper'


describe 'devpi::runit' do
  before(:each) do
    @chef_run = ChefSpec::ChefRunner.new
  end

  context 'recipe' do
    subject { @chef_run.converge described_recipe }
    it { should include_recipe 'runit' }
    it { should include_recipe 'devpi::server' }
  end

  context 'runit service configuration' do
    subject {
      @chef_run.node.set[:devpiserver][:admin_group] = 'configured_group'
      @chef_run.converge described_recipe
      @chef_run.find_resource 'runit_service', 'devpi-server'
    }
    its(:owner) { should eq 'root' }
    its(:group) { should eq 'configured_group' }
  end

end
