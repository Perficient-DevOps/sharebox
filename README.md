# Overview

Simple Vagrant Box configured to expose a shared folder via various shared services for testing access methods or very simple local hosting from other vm's and containers that you may be testing with.

Possible to expose it via a bridged interface if you prefer by modifying the `Vagrantfile` accordingly but not really my use case here.

# Usage

Grab the source code.

    git clone https://github.com/Perficient-DevOps/sharebox.git
    cd sharebox

Modify `Vagrantfile` to some useful values for:

    local_share = 'c:/srv'
    box_ip      = '192.168.56.200'

Once you have your updates.

    vagrant up --provision

You could already `sftp`/`ssh` via `vagrant` user with read-write access, but now you can also access:
 * \\\&lt;box_ip&gt;\srv
 * nfs://&lt;box_ip&gt;/srv
 * http(s)://&lt;box_ip&gt;/
 * ftp://&lt;box_ip&gt;
