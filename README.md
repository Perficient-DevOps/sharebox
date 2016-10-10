# Overview

Simple Vagrant Box configured to expose a shared folder via various shared services for testing access methods or very simple local hosting from other vm's and containers that you may be testing with.

Possible to expose it via a bridged interface if you prefer by modifying the `Vagrantfile` accordingly but not really my use case here.

# Pre-Requisites

Requires that you have have installed [VirtualBox](https://www.virtualbox.org/wiki/Downloads) and [vagrant](https://www.vagrantup.com)

If you already have [Chocolatey](https://chocolatey.org/), which I recommend, this is an easy:

    choco install -y virtualbox vagrant

# Usage

Grab the source code.

    git clone https://github.com/Perficient-DevOps/sharebox.git
    cd sharebox

Now find your local ip address for the 'VirualBox Host Only Network', here you are looking for what your ip address is as shown below and want to use that information to determine an used ip address on that network. See the vagrant docs on [private networks](https://www.vagrantup.com/docs/networking/private_network.html) for more details, but one simple way to find your host-only interfaces is to just query all your local interfaces and look for `Host-Only` like the excerpt below:

    PS C:\workspace\sharebox> ipconfig

    Windows IP Configuration
    ... <truncated>
    Ethernet adapter VirtualBox Host-Only Network:

       Connection-specific DNS Suffix  . :
       Link-local IPv6 Address . . . . . : fe80::d8e9:61b3:db91:4554%6
       IPv4 Address. . . . . . . . . . . : 192.168.56.1
       Subnet Mask . . . . . . . . . . . : 255.255.255.0
       Default Gateway . . . . . . . . . :

    Wireless LAN adapter Wi-Fi:
    ... <truncated>

Additionally you can use the `VBoxManage` command on Windows, but you just need to add your VirtualBox bin directory to your path as this is not done by default. On my Mac, this is already be on the path so you can just use the `VBoxManage` command to inspect the host-only interfaces, once on your path the command is the same on Windows, Mac, and Linux as shown below on my mac:

    sgwilbur@gura:~/workspaces/sharebox$ VBoxManage list hostonlyifs
    Name:            vboxnet0
    GUID:            786f6276-656e-4074-8000-0a0027000000
    DHCP:            Disabled
    IPAddress:       192.168.56.1
    NetworkMask:     255.255.255.0
    IPV6Address:     
    IPV6NetworkMaskPrefixLength: 0
    HardwareAddress: 0a:00:27:00:00:00
    MediumType:      Ethernet
    Status:          Down
    VBoxNetworkName: HostInterfaceNetworking-vboxnet0

Once you identify the correct network, here 192.168.56.0/24 you pick an ip address that you think is not in use, the default dhcp range on a host-only network is 101-254 so while me picking 200 is a possible conflict, I only usually have between 5-10 virtualbox machines setup at any given time so it is very unlikely to conflict.


Modify `Vagrantfile` to relevant values for your machine:

    ############################################################
    # TODO: Update to your desired values
    ############################################################
    local_share = 'c:/srv'
    box_ip      = '192.168.56.200'
    ############################################################

Once you have your updates.

    vagrant up --provision

This process will download the box file, and provision the server with the *Vagrant* `chef_zero` provisioner using the `sharebox` cookbook embedded in this repo to configure a few other sharing services in a default configuration. You could already `sftp`/`ssh` via `vagrant` user with read-write access, but now you can also access:

 * \\\\&lt;box_ip&gt;\srv
 * nfs://&lt;box_ip&gt;/srv
 * http(s)://&lt;box_ip&gt;/
 * ftp://&lt;box_ip&gt;
