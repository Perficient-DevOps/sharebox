# Simple HTTP Server using nginx
# https://help.ubuntu.com/community/Nginx

apt_package 'nginx'

# Quick inline setup of web server as default site
file '/etc/nginx/sites-enabled/default' do
  content <<-EOF.gsub(/^ {4}/, '')
    server {
      listen #{ node['sharebox']['http']['port'] } default_server;
      listen [::]:#{ node['sharebox']['http']['port'] } default_server ipv6only=on;
      root #{ node['sharebox']['share']['path'] };
      index index.html index.htm;
      server_name localhost;
      location / {
        autoindex on;
        try_files $uri $uri/ =404;
      }
    }
  EOF
end

service 'nginx' do
  supports :restart => true
  action [ :enable, :restart ]
end
