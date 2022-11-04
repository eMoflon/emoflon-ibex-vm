Vagrant.configure("2") do |config|
    config.vm.box = "gusztavvargadr/ubuntu-desktop"
    config.vm.define 'ubuntu'
    config.vm.provider :virtualbox do |vb|
        vb.name = "gips"
    end
    config.vm.provision "shell", path: "prov.sh", privileged: false

    # Prevent SharedFoldersEnableSymlinksCreate errors
    config.vm.synced_folder ".", "/vagrant", disabled: true
end
