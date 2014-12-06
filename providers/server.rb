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

  root_directory = new_resource.directory
  data_directory = new_resource.data_directory || ::File.join([
    root_directory, 'data'])
  port = new_resource.port
  daemon_user = new_resource.daemon_user
  admin_group = new_resource.admin_group

  directory root_directory do
    action :create
    recursive true
  end

  python_virtualenv root_directory do
    action :create
  end

  python_pip 'devpi-server' do
    virtualenv root_directory
    version new_resource.version unless new_resource.version.nil?
  end

  user "Daemon user for #{root_directory}" do
    username daemon_user
    gid 'daemon'
    home root_directory
    comment 'Dev-pi Server privilege separation user'
    shell '/bin/false'
    system true
    action :create
    not_if "id #{daemon_user}"
  end

  group "Admin group for #{root_directory}" do
    group_name admin_group
    system true
    action :create
  end

  directory data_directory do
    action :create
    owner daemon_user
    group admin_group
    mode 00770
    recursive true
  end

  command_root = %W(
    #{root_directory}/bin/devpi-server --serverdir "#{data_directory}"
  ).join(' ')
  unless ::File.exist?(::File.join([data_directory, '.event_serial']))
    execute 'start devpi-server' do
      cwd root_directory
      command "#{command_root} --port #{port} --start"
      user daemon_user
    end
    execute 'stop devpi-server' do
      cwd root_directory
      command "#{command_root} --stop"
      user daemon_user
    end
  end

  if new_resource.nginx_site
    include_recipe 'nginx'
    service 'nginx' do
      action :nothing
    end
    devpi_nginx_site new_resource.nginx_site do
      directory root_directory
      data_directory data_directory
      port port
      daemon_user daemon_user
      admin_group admin_group
    end
    nginx_site 'default' do
      enable false
    end
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
