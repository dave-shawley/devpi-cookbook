require 'chefspec'
require 'spec_helper'


describe 'devpi::runit' do
  before(:each) do
    @chef_run = ChefSpec::ChefRunner.new
  end

  context 'recipe' do
    subject { @chef_run.converge described_recipe }
  end

end
