require 'chefspec'

describe 'devpi::default' do
  let (:chef_run) { ChefSpec::ChefRunner.new.converge 'devpi::default' }
  it 'should do something' do
    pending 'Your recipe examples go here.'
  end
end
