#
# Cookbook Name:: devpi
# Provider:: devpi_nginx_site
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
  service 'nginx' do
    action :nothing
  end

  data_dir = new_resource.data_directory || ::File.join(
    [new_resource.directory, 'data'])

  bash "generate nginx config for #{new_resource.name}" do
    cwd '/tmp'
    code <<-EOC
      #{new_resource.directory}/bin/devpi-server \
        --serverdir #{data_dir} --outside-url='http://#{node['fqdn']}:80/' \
        --port #{new_resource.port} --gen-config
      install -o root -g #{new_resource.admin_group} -m 0664 \
        gen-config/nginx-devpi.conf \
        #{node['nginx']['dir']}/sites-available/#{new_resource.name}
      rm -fr gen-config
      chown -R #{new_resource.daemon_user} #{data_dir}
      chgrp -R #{new_resource.admin_group} #{data_dir}
    EOC
  end
  bash "fix nginx config for #{new_resource.name}" do
    cwd "#{node['nginx']['dir']}/sites-available"
    code <<-EOC
    sed -i -e '\
      s/server_name #{node['fqdn']};/server_name $hostname "";/; \
      s/#dynamic: proxy_set_header/proxy_set_header/; \
      /proxy_set_header  X-outside-url/d; \
    ' devpi-server
    EOC
    notifies :reload, 'service[nginx]'
  end
  if new_resource.enable
    nginx_site new_resource.name do
      enable true
    end
  end
end
