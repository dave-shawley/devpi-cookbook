#
# Cookbook Name:: replica-test
# Recipe:: master
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

devpi_server '/opt/devpi/master' do
  port 3142
end

supervisor_service 'devpi-master' do
  command '/opt/devpi/master/bin/devpi-server --port 3142 --role master --serverdir /opt/devpi/master/data'
  user 'devpi'
  action :enable
  autostart true
end
