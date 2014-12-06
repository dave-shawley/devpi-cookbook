#
# Cookbook Name:: devpi
# Resource:: devpi_server
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

actions :create, :delete
default_action :create

attribute :directory, kind_of: String, name_attribute: true
attribute :daemon_user, kind_of: String, default: 'devpi'
attribute :admin_group, kind_of: String, default: 'devpi'
attribute :port, kind_of: Integer, default: 3141
attribute :data_directory, kind_of: String
attribute :nginx_site, kind_of: [String, NilClass], default: nil
attribute :version, kind_of: [String, NilClass], default: nil

state_attrs :version, :directory
