#! /bin/sh

if [ -e /home/vagrant/.ubuntu_install_done ]; then
	echo "ubuntu install already done"
	exit
else
	echo "ubuntu install"
	sed -i 's/^DNS=/#DNS=/' /etc/systemd/resolved.conf
	sed -i 's/DNSSEC=yes/DNSSEC=no' /etc/systemd/resolved.conf

	netplan generate
	netplan apply
	systemctl restart systemd-resolved
	sleep 4
	resolvectl flush-caches
	touch /home/vagrant/.ubuntu_install_done
fi
