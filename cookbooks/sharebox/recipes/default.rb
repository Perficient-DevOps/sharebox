#
# Cookbook Name:: sharebox
# Recipe:: default
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

# Update apt
apt_update 'Update apt' do
  action :update
end

include_recipe 'sharebox::ftp'
include_recipe 'sharebox::http'
include_recipe 'sharebox::nfs'
include_recipe 'sharebox::samba'
