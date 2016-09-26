# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|

  # TODO: Update to your desired values
  local_share = 'c:/srv'
  box_ip      = '192.168.56.200'

  if Vagrant.has_plugin?("vagrant-cachier")
    config.cache.scope = :box
  end

  config.vm.box_check_update = false
  config.vm.box = "bento/ubuntu-14.04"
  config.vm.network "private_network", ip: "192.168.56.200"
  config.vm.synced_folder "c:/srv", "/srv"

  # Configured to be a small foot print here.
  config.vm.provider "virtualbox" do |vb|
    vb.gui = false
    vb.memory = "512"
  end

  # Do the chef provisioning
  config.vm.provision :chef_solo do |chef|
    # Paths to your cookbooks (on the host)
    chef.cookbooks_path = ["cookbooks"]
    # Add chef recipes
    recipes = [ 'sharebox' ]
    recipes.each do | recipe |
      chef.add_recipe recipe
    end
  end

end
