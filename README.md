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

Now find your local ip address for the 'VirualBox Host Only Network', here you are looking for what your ip address is as shown below and want to use that information to determine an used ip address on that network. See the vagrant docs on [private networks](https://www.vagrantup.com/docs/networking/private_network.html) for more details:

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
