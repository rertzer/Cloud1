#! /bin/sh

if [ -e /home/vagrant/.ansible_install_done ]; then
	echo "ansible install already done"
	exit
else

	echo "installing ansible.."
	sudo apt update
	sudo NEEDRESTART_MODE=a apt install python3-pip -y
	sudo python3 -m pip install ansible
	ansible-galaxy collection install community.docker

	touch /home/vagrant/.ansible_install_done
fi
