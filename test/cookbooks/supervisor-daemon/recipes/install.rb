#
# Cookbook Name:: supervisor-daemon
# Recipe:: install
#
# Installs the init scripts necessary to run the supervisor daemon on
# RHEL derived systems.
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

if node[:platform] == 'centos'
  template '/etc/default/supervisord' do
    source 'supervisor.default.erb'
    owner 'root'
    mode 00644
  end

  template '/etc/init.d/supervisord' do
    source 'supervisor.init.erb'
    owner 'root'
    mode 00755
  end

  bash 'enable supervisord service' do
    user 'root'
    code 'chkconfig supervisord on'
  end

  service 'supervisord' do
    action :start
  end
end
