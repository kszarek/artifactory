#
# Cookbook Name:: artifactory
# Recipe:: apache-proxy
#
# Copyright (C) 2013 Fewbytes
#
# Apache V2

include_recipe 'artifactory'
include_recipe 'apache2'
include_recipe 'apache2::mod_proxy_http'

host_name = node['artifactory']['host_name'] || node['fqdn']

template "#{node['apache']['dir']}/sites-available/artifactory.conf" do
  source 'apache-artifactory-vhost.conf.erb'
  owner 'root'
  group 'root'
  mode '0644'
  variables(
    host_name: host_name
  )

  if File.exist?("#{node['apache']['dir']}/sites-enabled/artifactory.conf")
    notifies :restart, 'service[apache2]'
  end
end

apache_site 'artifactory.conf' do
  enable true
end
