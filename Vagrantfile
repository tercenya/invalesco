# -*- mode: ruby -*-
# vi: set ft=ruby :

require 'berkshelf/vagrant'

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.require_version ">= 1.5.0"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.berkshelf.enabled = true
  config.omnibus.chef_version = :latest

  config.vm.hostname = "invalesco"
  config.vm.box = "trusty64"

  config.vm.provider "vmware_fusion" do |v, override|
    v.gui = false
    v.vmx["numvcpus"] = "8"
    v.vmx["memsize"] = "8096"
  end

  # An array of symbols representing groups of cookbook described in the Vagrantfile
  # to exclusively install and copy to Vagrant's shelf.
  # config.berkshelf.only = []

  # An array of symbols representing groups of cookbook described in the Vagrantfile
  # to skip installing and copying to Vagrant's shelf.
  # config.berkshelf.except = []

  config.vm.provision :chef_solo do |chef|
    chef.run_list = [
        "recipe[afpc::vagrant]",
    ]
  end

  config.vm.synced_folder "/code/lol/invalesco", "/opt/invalesco"

  config.vm.network "forwarded_port", guest: 3000, host: 3002 # nginx
  # config.vm.network "forwarded_port", guest: 6379, host: 6379 # redis
  config.vm.network "forwarded_port", guest: 27017, host: 27018 # mongodb
end
