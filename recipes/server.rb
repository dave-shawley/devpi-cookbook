#
# Cookbook Name:: devpi
# Recipe:: server
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

include_recipe 'python'

python_virtualenv 'devpi environment' do
  path node['devpiserver']['virtualenv']
  action :create
end

user 'devpi privilege separation user' do
  username node['devpiserver']['daemon_user']
  gid 'daemon'
  home node['devpiserver']['virtualenv']
  comment 'Devpi-server privilege separation user.'
  shell '/bin/false'
  system
  action :create
end

group 'devpi administrative group' do
  group_name node['devpiserver']['admin_group']
  members node['devpiserver']['daemon_user']
end

python_pip 'devpi-server' do
  package_name 'devpi-server'
  action :upgrade
  virtualenv node['devpiserver']['virtualenv']
  version node['devpiserver']['version'] if node['devpiserver'].key? 'version'
end

directory 'devpi-server directory' do
  action :create
  path node['devpiserver']['server_root']
  owner node['devpiserver']['daemon_user']
  group node['devpiserver']['admin_group']
  mode 00770
end
