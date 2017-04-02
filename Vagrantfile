# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|

  # Base VM configuration
  config.vm.box = "v0rtex/xenial64"

  # VM specs
  config.vm.provider "virtualbox" do |v|
    # FIXME: Use half of what's available to the host OS
    # instead of these hard coded values
    v.memory = 4096
    v.cpus = 2
  end

  # Enable provisioning with a shell script
  config.vm.provision "shell", path: "provision.sh"

end
