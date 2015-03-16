#
# Cookbook Name:: replica-test
# Recipe:: replica
#
# Copyright 2015, Dave Shawley
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
include_recipe 'supervisor'

devpi_server '/opt/devpi/slave' do
  port 3143
end

supervisor_service 'devpi-replica' do
  command '/opt/devpi/slave/bin/devpi-server --port 3143 --role replica --master-url http://localhost:3142 --serverdir /opt/devpi/slave/data'
  user 'devpi'
  action :enable
  autostart true
end
