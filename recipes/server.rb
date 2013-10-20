#
# Cookbook Name:: devpi
# Recipe:: server
#
# Copyright 2013, Dave Shawley
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
  path node[:devpiserver][:virtualenv]
  action :create
end

user 'devpi privilege separation user' do
  username node[:devpiserver][:daemon_user]
  gid 'daemon'
  comment 'Devpi-server privilege separation user.'
  shell '/bin/false'
  system
  action :create
end

python_pip 'devpi server' do
  package_name 'devpi-server'
  action :upgrade
  virtualenv '/opt/devpi-server'
  version node[:devpiserver][:version] if node[:devpiserver].key? :version
end
