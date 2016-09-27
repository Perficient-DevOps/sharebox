# Expose the shared directory via nfs
# https://help.ubuntu.com/community/SettingUpNFSHowTo

# Install required package
apt_package 'nfs-kernel-server'

# Apply our exports template
template '/etc/exports' do
  action :create
  backup false
  source 'exports.erb'
  variables( :share_path => node['sharebox']['share']['path'] )
end

service 'nfs-kernel-server' do
  pattern 'nfs-kernel-server' # look for by name
  supports :restart => true
  action [ :enable, :restart ]
end

# TODO: Firewall Rules, RPC bind lockdown...
