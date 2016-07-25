require 'yaml'

MACHINES_FILE='machines.yaml'
SHARE_DIR='vagrant-test'

machines = YAML::load_file(MACHINES_FILE)['machines']

Vagrant.configure('2') do |config|

  # Make sure shared directory exists
  unless File.directory? SHARE_DIR
    Dir.mkdir SHARE_DIR
  end

  config.hostmanager.enabled = true
  config.hostmanager.manage_guest = true
  config.vm.provision :hostmanager

  #config.vm.synced_folder 'vagrant-test/', '/usr/share/vagrant-test', type: 'nfs', mount_options: ["noatime", "nodiratime", "rsize=131072", "wsize=131072"]

  machines.each do |box|
    config.vm.define box['role'] do |machine|
      machine.vm.hostname = "#{box['role']}.vagrant"
      machine.vm.network :private_network, :ip => box['ip']
      machine.vm.box = box['template']
      unless box['preamble'].nil?
        machine.vm.provision :shell, :path => box['preamble'], :args => "#{box['role']}"
      end
    end
  end
end
