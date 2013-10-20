require 'chefspec'
require 'spec_helper'


describe 'devpi::server' do

  before(:each) do
    @chef_run = ChefSpec::ChefRunner.new
  end

  it 'should install python' do
    @chef_run.converge described_recipe
    expect(@chef_run).to include_recipe 'python'
  end

end
