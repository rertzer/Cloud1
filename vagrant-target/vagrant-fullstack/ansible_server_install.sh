#! /bin/sh

if [ -e /home/vagrant/.ansible_install_done ]; then
	echo "ansible install already done"
	exit
else
	echo "installing docker"
	apt update
	apt install ca-certificates curl -y
	install -m 0755 -d /etc/apt/keyrings
	curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
	chmod a+r /etc/apt/keyrings/docker.asc

	# Add the repository to Apt sources:
	tee /etc/apt/sources.list.d/docker.sources <<EOF
Types: deb
URIs: https://download.docker.com/linux/ubuntu
Suites: jammy 
Components: stable
Architectures: amd64 
Signed-By: /etc/apt/keyrings/docker.asc
EOF

	apt update
	apt install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin -y

	adduser vagrant docker

	echo "installing ansible..."
	apt update && apt install ansible-core -y

	touch /home/vagrant/.ansible_install_done
fi
