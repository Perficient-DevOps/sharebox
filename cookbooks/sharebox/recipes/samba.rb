# Expose the shared directory via Samba/NFS

# install require packages
apt_package 'samba'

# apply our simple Samba configuration
template '/etc/samba/smb.conf' do
  action :create
  backup false
  source 'smb.conf.erb'
  variables(
    :share_name => node['sharebox']['share']['name'],
    :share_path => node['sharebox']['share']['path']
    )
end

# Enable service and restart samba if it happens to already be running
service 'samba' do
  # Research: Why this is not the default for 14.04 ?
  # Cause is Ubuntu not completely implementing Upstart https://github.com/chef/inspec/issues/226
  # Result: Upstart is not defaul https://blog.chef.io/2014/09/18/chef-where-is-my-ubuntu-14-04-service-support/
  ## provider Chef::Provider::Service::Upstart
  pattern 'mbd' # looking for smbd & nmbd
  supports :restart => true
  action [ :enable, :restart ]
end

# TODO: Add firewall rules
