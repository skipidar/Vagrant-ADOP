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
	config.vm.box = "boxcutter/ubuntu1604"

	# The url from where the 'config.vm.box' box will be fetched if it
	# doesn't already exist on the user's system.
	config.vm.box_url = "https://app.vagrantup.com/boxcutter/boxes/ubuntu1604"

	# memory increase
	config.vm.provider "virtualbox" do |v|
        v.memory = 14336
        v.cpus = 4
    end
	
	
	
	# forward ports

	# ldap
	config.vm.network :forwarded_port, guest: 8081, host: 80
	config.vm.network :forwarded_port, guest: 80, host: 80

					  

	# CUSTOMISATION OF THE VM HERE
	PATH_VAGRANT_PROJECT=File.dirname(__FILE__)
	BOX_IMAGE = "boxcutter/ubuntu1604"
  
  
	# add the file with the test passwords
	config.vm.provision "file", source: "#{PATH_VAGRANT_PROJECT}\\platform.secrets.sh", destination: "/home/vagrant/platform.secrets.sh"
  
  
	# Use shell script to provision
	config.vm.provision "shell", inline: <<-SHELL


		#########################
		# ADOP Requirements
		#########################
		
		apt-get update
		
		
		# install a daemon to manage swap dynamically
		sudo apt install swapspace -y

		# install docker
		apt-get -y install docker.io
		
		# install docker compose
		curl -L https://github.com/docker/compose/releases/download/1.16.1/docker-compose-`uname -s`-`uname -m` -o /usr/local/bin/docker-compose
		
		# allow execution of docker compose
		chmod +x /usr/local/bin/docker-compose
				
		
		#########################
		# now deploy ADOP
		#########################
		

		# get adop from github
		cd ~
		git clone https://github.com/Accenture/adop-docker-compose
		cd ~/adop-docker-compose
		
		cp /home/vagrant/platform.secrets.sh ~/adop-docker-compose/

		# SINCE WE DONT USE DOCKER-MACHINE - one cant use quickstart, but use "adop compose" directly, which will default to localhost
		# quickstart is the usual entry-point, which requires the docker-machine
		# ./quickstart.sh -t local -m "adopmachine" -c "NA" -u "user" -p "123abc"

		
		bash ./adop compose init
		
		
		# display the secrets, to know what to use for login
		cat "~/adop-docker-compose/platform.secrets.sh"
		
	SHELL
  
end
