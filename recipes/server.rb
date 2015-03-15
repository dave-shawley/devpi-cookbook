#
# Cookbook Name:: devpi
# Recipe:: server
#
# Copyright 2013-2015, Dave Shawley
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

devpi_server node['devpiserver']['virtualenv'] do
  daemon_user node['devpiserver']['daemon_user']
  admin_group node['devpiserver']['admin_group']
  version node['devpiserver']['version'] if node['devpiserver'].key? 'version'
  data_directory node['devpiserver']['server_root']
end
