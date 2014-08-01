#
# Cookbook Name:: devpi
# Recipe:: supervisor
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

include_recipe 'supervisor'
include_recipe 'devpi::server'

supervisor_service 'devpi-server' do
  action :enable
  command("#{node[:devpiserver][:virtualenv]}/bin/devpi-server" \
    " --port #{node[:devpiserver][:server_port]}" \
    " --serverdir #{node[:devpiserver][:server_root]}")
  user node[:devpiserver][:daemon_user]
end
