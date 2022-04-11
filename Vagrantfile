# -*- mode: ruby -*-
# vi: set ft=ruby :

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.
Vagrant.configure("2") do |config|
  # The most common configuration options are documented and commented below.
  # For a complete reference, please see the online documentation at
  # https://docs.vagrantup.com.

  # Every Vagrant development environment requires a box. You can search for
  # boxes at https://vagrantcloud.com/search.
  config.vm.box = "ubuntu/focal64"

  # Disable automatic box update checking. If you disable this, then
  # boxes will only be checked for updates when the user runs
  # `vagrant box outdated`. This is not recommended.
  # config.vm.box_check_update = false

  # Create a forwarded port mapping which allows access to a specific port
  # within the machine from a port on the host machine. In the example below,
  # accessing "localhost:8080" will access port 80 on the guest machine.
  # NOTE: This will enable public access to the opened port
  # config.vm.network "forwarded_port", guest: 80, host: 8080

  # Create a forwarded port mapping which allows access to a specific port
  # within the machine from a port on the host machine and only allow access
  # via 127.0.0.1 to disable public access
  config.vm.network "forwarded_port", guest: 8081, host: 8080, host_ip: "127.0.0.1"

  # Create a private network, which allows host-only access to the machine
  # using a specific IP.
  # config.vm.network "private_network", ip: "192.168.33.10"

  # Create a public network, which generally matched to bridged network.
  # Bridged networks make the machine appear as another physical device on
  # your network.
  # config.vm.network "public_network"

  # Share an additional folder to the guest VM. The first argument is
  # the path on the host to the actual folder. The second argument is
  # the path on the guest to mount the folder. And the optional third
  # argument is a set of non-required options.
  # config.vm.synced_folder "../data", "/vagrant_data"

  # Provider-specific configuration so you can fine-tune various
  # backing providers for Vagrant. These expose provider-specific options.
  # Example for VirtualBox:
  #
  config.vm.provider "virtualbox" do |vb|
    # Customize the amount of memory on the VM:
    vb.memory = "4096"
  end
  #
  # View the documentation for the provider you are using for more
  # information on available options.

  # Enable provisioning with a shell script. Additional provisioners such as
  # Ansible, Chef, Docker, Puppet and Salt are also available. Please see the
  # documentation for more information about their specific syntax and use.
  config.vm.provision "shell", inline: <<-SHELL
    export DEBIAN_FRONTEND=noninteractive
    apt-get --quiet update
    apt-get --quiet --assume-yes install docker.io jq
    adduser vagrant docker
  SHELL

  config.vm.provision "nexus", type: "shell", inline: <<-SHELL
    cd /vagrant/nexus
    export NEXUS_IMAGE_NAME="nexus_playground"
    export NEXUS_CONTAINER_NAME="nexus"
    export NEXUS_ADMIN_PASSWORD="admin"
    export NEXUS_URL="http://localhost:8081"
    ./build_docker_image.sh
    ./remove_nexus_container.sh || true
    EXTRA_DOCKER_ARGS="-p 8081:8081" ./launch_nexus_container.sh
    ./wait_for_writable.sh
    ./set_unsecure_but_friendly_admin_pass.sh
    ./disable_anonymous_access.sh
  SHELL
  config.vm.provision "npm_install_performance", type: "shell", run: "never", inline: <<-SHELL
    cd /vagrant/nexus
    echo "Adding 10k users"
    export NEXUS_ADMIN_PASSWORD="admin"
    export NEXUS_URL="http://localhost:8081"
    CUSTOM_SCRIPT_FILE_PATH="test_scenarios/npm_users_performance/create_users_and_repo.groovy" ./run_groovy_script.sh

    echo "5 test installs of a sample npm package" 
    for n in $(seq 1 5); do
      ./test_scenarios/npm_users_performance/test_npm_install.sh
    done
  SHELL
  config.vm.provision "npm_token_creation_performance_fix", type: "shell", run: "never", inline: <<-SHELL
    cd /vagrant/nexus
    echo "Adding an index to speed up creating npm tokens"
    docker stop nexus
    docker ps
    docker run --volumes-from nexus sonatype/nexus3:3.38.0 bash -c "java -jar /opt/sonatype/nexus/lib/support/nexus-orient-console.jar 'connect plocal:/nexus-data/db/security admin admin; create index api_key_primary_principal on api_key (primary_principal) notunique'"
    docker start nexus
    ./wait_for_writable.sh
  SHELL
  config.vm.provision "npm_token_creation_performance", type: "shell", run: "never", inline: <<-SHELL
    cd /vagrant/nexus
    echo "Adding 10k users"
    export NEXUS_ADMIN_PASSWORD="admin"
    export NEXUS_URL="http://localhost:8081"
    CUSTOM_SCRIPT_FILE_PATH="test_scenarios/npm_users_performance/create_users_and_repo.groovy" ./run_groovy_script.sh

    echo "Creating npm tokens for 5k users"
    ./test_scenarios/npm_users_performance/create_npm_tokens.sh
  SHELL
end
