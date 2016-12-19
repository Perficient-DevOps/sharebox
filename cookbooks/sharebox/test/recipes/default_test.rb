# # encoding: utf-8
# Inspec test for recipe sharebox::default

## FTP
describe port(21) do
  it { should be_listening }
  its('addresses') { should include '0.0.0.0' }
end

## HTTP
describe port(80) do
  it { should be_listening }
  its('addresses') { should include '0.0.0.0' }
end

## NFS
describe port(111) do
  it { should be_listening }
  its('addresses') { should include '0.0.0.0' }
  its('protocols') { should include 'tcp'}
  its('protocols') { should include 'udp'}
end

## Samba
## TCP 139,445 UDP 137,138
describe port(139) do
  it { should be_listening }
  its('addresses') { should include '0.0.0.0' }
  its('protocols') { should include 'tcp' }
end
describe port(445) do
  it { should be_listening }
  its('addresses') { should include '0.0.0.0' }
  its('protocols') { should include 'tcp' }
end
