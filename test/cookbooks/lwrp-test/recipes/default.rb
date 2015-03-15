#
# Cookbook Name:: lwrp-test
# Recipe:: default
#
# Copyright 2014-2015, Dave Shawley
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

devpi_server '/opt/devpi/default-server'

devpi_server '/opt/devpi/devpi-server-2.0.0' do
  version '2.0.0'
  port 3142
end

devpi_server '/opt/devpi/external-data-server' do
  data_directory '/opt/devpi/data'
  port 3143
end

devpi_server '/opt/devpi/nginx-enabled' do
  nginx_site 'devpi'
  port 3144
end

devpi_server '/opt/devpi/should-not-exist' do
  nginx_site 'should-be-removed'
end

devpi_server '/opt/devpi/should-not-exist' do
  nginx_site 'should-be-removed'
  action :delete
end
