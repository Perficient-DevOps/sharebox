# Expose the share via ftp
# https://help.ubuntu.com/community/vsftpd
# https://help.ubuntu.com/lts/serverguide/ftp-server.html

# Install the vsftpd server
apt_package 'vsftpd'

# Update configuration with our non-default to serve anonymously
template '/etc/vsftpd.conf' do
  action :create
  backup 1                      # keep last backup only
  source 'vsftpd.conf.erb'
end

# Set ftp home directory
user 'ftp' do
  home "#{ node['sharebox']['share'] }"
end

# Enable and restart service
service 'vsftpd' do
  supports :restart => true
  action [ :enable, :restart ]
end
