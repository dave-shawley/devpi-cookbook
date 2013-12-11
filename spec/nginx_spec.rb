require 'spec_helper'

describe 'devpi::nginx' do
  before(:each) do
    @chef_run = ChefSpec::Runner.new
  end

  context 'this recipe' do
    subject {
      @chef_run.converge(described_recipe)
    }
    it { should include_recipe 'nginx::package' }
    it { should render_file '/etc/nginx/sites-available/devpi-server' }
    # the following does not work!?
    # it { should run_execute 'nxdissite default' }
    it { should run_execute 'nxensite devpi-server' }
  end

  context 'devpi-server site' do
    subject {
      @chef_run.node.set[:devpiserver][:server_port] = 5678
      @chef_run.converge described_recipe
    }
    it {
      should render_file('/etc/nginx/sites-available/devpi-server')\
        .with_content('server 127.0.0.1:5678')
    }
    it {
      should render_file('/etc/nginx/sites-available/devpi-server')\
        .with_content('server_name fauxhai.local')
    }
  end

  context 'devpi-server site template' do
    subject {
      @chef_run.converge described_recipe
      @chef_run.find_resource(
        'template', '/etc/nginx/sites-available/devpi-server')
    }
    it { should_not be_nil }
    it { should notify('service[nginx]').to :start }
  end

  context 'when nginx dir is /foo' do
    subject {
      @chef_run.node.set[:nginx][:dir] = '/foo'
      @chef_run.converge described_recipe
    }
    it { should render_file '/foo/sites-available/devpi-server' }
  end
end
