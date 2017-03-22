# Vagrantfile for setting up a build environment of a LineageOS ROM on a Vultr
# VPS. Requires vagrant-vultr (https://github.com/p0deje/vagrant-vultr).

PRIV_KEY = '~/.ssh/id_rsa@vultr.com'
API_TOKEN = ''
REGION = 'Tokyo'

Vagrant.configure(2) do |config|
  config.vm.provider :vultr do |vultr, override|
    override.nfs.functional = false
    override.ssh.private_key_path = PRIV_KEY
    override.vm.box = 'vultr'
    override.vm.box_url = 'https://github.com/p0deje/vagrant-vultr/raw/master/box/vultr.box'

    vultr.token = API_TOKEN
    vultr.region = REGION
    vultr.plan = '16384 MB RAM,200 GB SSD,5.00 TB BW'
    vultr.os = 'Ubuntu 16.10 x64'
  end

  config.vm.provision 'shell', path: 'adduser.sh'
  config.vm.provision 'shell', path: 'provision.sh'
end
