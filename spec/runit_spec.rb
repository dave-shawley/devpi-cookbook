require 'chefspec'
require 'spec_helper'


describe 'devpi::runit' do
  before(:each) do
    @chef_run = ChefSpec::ChefRunner.new
  end

  context 'recipe' do
    subject { @chef_run.converge described_recipe }
    it { should include_recipe 'runit' }
  end

end
