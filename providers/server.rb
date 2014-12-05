#
# Cookbook Name:: devpi
# Provider:: devpi_server
#
# Copyright 2013-2014, Dave Shawley
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

include Chef::DSL::IncludeRecipe

def whyrun_supported?
  true
end

use_inline_resources if defined? use_inline_resources

action :create do
  include_recipe 'python'

  directory new_resource.directory do
    action :create
    recursive true
  end

  python_virtualenv new_resource.directory do
    action :create
  end

  python_pip 'devpi-server' do
    virtualenv new_resource.directory
    version new_resource.version unless new_resource.version.nil?
  end

  user "Daemon user for #{new_resource.directory}" do
    username new_resource.daemon_user
    gid 'daemon'
    home new_resource.directory
    comment 'Dev-pi Server privilege separation user'
    shell '/bin/false'
    system true
    action :create
    not_if "id #{new_resource.daemon_user}"
  end

  group "Admin group for #{new_resource.directory}" do
    group_name new_resource.admin_group
    system true
    action :create
  end

  data_dir = new_resource.data_directory || ::File.join([
    new_resource.directory, 'data'])
  directory data_dir do
    action :create
    owner new_resource.daemon_user
    group new_resource.admin_group
    mode 00770
    recursive true
  end

  command_root = %W(
    #{new_resource.directory}/bin/devpi-server --serverdir "#{data_dir}"
  ).join(' ')
  unless ::File.exist?(::File.join([data_dir, '.event_serial']))
    execute 'start devpi-server' do
      cwd new_resource.directory
      command "#{command_root} --port #{new_resource.port} --start"
      user new_resource.daemon_user
    end
    execute 'stop devpi-server' do
      cwd new_resource.directory
      command "#{command_root} --stop"
      user new_resource.daemon_user
    end
  end

  if new_resource.nginx_site
    include_recipe 'nginx'
    service 'nginx' do
      action :nothing
    end
    execute "generate #{new_resource.nginx_site}" do
      cwd '/tmp'
      command "#{command_root} --port #{new_resource.port} --gen-config"
    end
    execute "install #{new_resource.nginx_site}" do
      cwd '/tmp'
      command %W(
        install
        -o root -g #{new_resource.admin_group} -m 0664
        /tmp/gen-config/nginx-devpi.conf
        #{node['nginx']['dir']}/sites-available/#{new_resource.nginx_site}
      ).join(' ')
    end
    directory "remove #{new_resource.nginx_site} temp config" do
      path '/tmp/gen-config'
      action :delete
      recursive true
    end
    nginx_site 'default' do
      enable false
    end
    nginx_site new_resource.nginx_site
  end

  new_resource.updated_by_last_action(true)
end

action :delete do
  directory "deleting #{new_resource.directory}" do
    path new_resource.directory
    action :delete
    recursive true
  end
  if new_resource.nginx_site
    include_recipe 'nginx'
    service 'nginx' do
      action :nothing
    end
    nginx_site new_resource.nginx_site do
      enable false
    end
    execute "remove nginx site for #{new_resource.directory}" do
      cwd node['nginx']['dir']
      command "rm sites-available/#{new_resource.nginx_site}"
    end
  end
  new_resource.updated_by_last_action(true)
end
